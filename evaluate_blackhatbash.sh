#!/bin/bash

##############################################################################
# SCRIPT: evaluate_blackhatbash.sh
# PROPÓSITO: Calificar la rama 'blackhatbash' del repositorio UNIX-02-SIN-B
# AUTOR: Daniel Villarreal / Optimizado Final
# FECHA: 2026
#
# USO: ./evaluate_blackhatbash.sh [ruta_al_repo] [rama]
##############################################################################

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

REPO_PATH="${1:-.}"
BRANCH_NAME="${2:-blackhatbash}"
TEMP_DIR="/tmp/blackhatbash_eval_$$"
REPORT_DIR="./blackhatbash_reports"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
EXEMPTION_DATE="2026-06-19"
JSON_REPORT="${REPORT_DIR}/rubrica_${TIMESTAMP}.json"
HTML_REPORT="${REPORT_DIR}/rubrica_${TIMESTAMP}.html"
ECUADOR_TZ="America/Guayaquil"

log_header() {
    echo -e "\n${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}\n"
}
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

validate_repo() {
    if [ ! -d "$REPO_PATH/.git" ]; then
        log_error "No se encontró un repositorio Git en: $REPO_PATH"
        exit 1
    fi
    log_success "Repositorio Git validado en: $REPO_PATH"
}

validate_branch() {
    cd "$REPO_PATH"
    if ! git rev-parse --verify "$BRANCH_NAME" &>/dev/null; then
        log_error "La rama '$BRANCH_NAME' no existe en el repositorio"
        git branch -a | sed 's/^/  /'
        exit 1
    fi
    log_success "Rama '$BRANCH_NAME' encontrada"
}

get_commit_data() {
    cd "$REPO_PATH"
    git log "$BRANCH_NAME" --pretty=format:"%H|%aI|%s|%b" > "$TEMP_DIR/commits_full.txt" 2>/dev/null || true
}

calculate_commit_quality() {
    local score=0 commit_count=0 good_messages=0
    cd "$REPO_PATH"
    commit_count=$(git rev-list --count "$BRANCH_NAME" 2>/dev/null || echo 0)
    
    [ "$commit_count" -eq 0 ] && { echo "0"; return; }
    
    while IFS='|' read -r commit_hash _ subject _; do
        [ -z "$commit_hash" ] && continue
        local msg_length=${#subject}
        
        if [[ "$subject" =~ ^[A-Z] ]] && [ "$msg_length" -gt 5 ]; then
            ((good_messages++))
        elif [[ "$subject" =~ ^(feat|fix|docs|style|refactor|test|chore|update|add|remove|wip): ]]; then
            ((good_messages++))
        fi
    done < "$TEMP_DIR/commits_full.txt"
    
    if [ "$commit_count" -gt 0 ]; then
        score=$((good_messages * 100 / commit_count))
        echo "$((score > 100 ? 100 : score))"
    else
        echo "0"
    fi
}

calculate_time_score() {
    local in_hours=0 out_hours=0 score=0 total=0
    
    while IFS='|' read -r commit_hash commit_time _ _; do
        [ -z "$commit_hash" ] && continue
        local hour commit_date
        hour=$(TZ="$ECUADOR_TZ" date -d "$commit_time" +%H 2>/dev/null || echo "12")
        commit_date=$(TZ="$ECUADOR_TZ" date -d "$commit_time" +%Y-%m-%d 2>/dev/null || echo "")
        
        if [ "$commit_date" == "$EXEMPTION_DATE" ] || { [ "$hour" -ge 6 ] && [ "$hour" -lt 23 ]; }; then
            ((in_hours++))
        else
            ((out_hours++))
        fi
    done < "$TEMP_DIR/commits_full.txt"
    
    total=$((in_hours + out_hours))
    [ "$total" -gt 0 ] && score=$((in_hours * 100 / total))
    echo "$score|$in_hours|$out_hours"
}

calculate_message_quality() {
    local excellent=0 good=0 poor=0 total=0 score=0
    
    while IFS='|' read -r commit_hash _ subject body; do
        [ -z "$commit_hash" ] && continue
        ((total++))
        local word_count
        word_count=$(echo "$subject" | wc -w)
        
        if [ -n "$body" ] && [ "$word_count" -ge 3 ]; then ((excellent++))
        elif [ "$word_count" -ge 3 ]; then ((good++))
        else ((poor++))
        fi
    done < "$TEMP_DIR/commits_full.txt"
    
    if [ "$total" -gt 0 ]; then
        score=$(( (excellent * 100 + good * 80 + poor * 40) / total ))
        echo "$((score > 100 ? 100 : score))|$excellent|$good|$poor|$total"
    else
        echo "0|0|0|0|0"
    fi
}

calculate_consistency() {
    local score=0 total_commits=0 days_span=0 commits_per_day=0 first_epoch last_epoch
    cd "$REPO_PATH"
    local first_commit_time last_commit_time
    first_commit_time=$(git log --format=%aI "$BRANCH_NAME" | tail -1 2>/dev/null || echo "")
    last_commit_time=$(git log --format=%aI "$BRANCH_NAME" | head -1 2>/dev/null || echo "")
    total_commits=$(git rev-list --count "$BRANCH_NAME" 2>/dev/null || echo "0")
    
    [ -z "$first_commit_time" ] || [ -z "$last_commit_time" ] && { echo "0|0|0|0"; return; }
    
    first_epoch=$(date -d "$first_commit_time" +%s 2>/dev/null || echo 0)
    last_epoch=$(date -d "$last_commit_time" +%s 2>/dev/null || echo 0)
    
    [ "$last_epoch" -gt "$first_epoch" ] && days_span=$(( (last_epoch - first_epoch) / 86400 ))
    days_span=$(( days_span == 0 ? 1 : days_span ))
    commits_per_day=$((total_commits / days_span))
    
    if [ "$commits_per_day" -ge 1 ] && [ "$commits_per_day" -le 10 ]; then score=100
    elif [ "$commits_per_day" -gt 10 ]; then score=85
    else score=70
    fi

    echo "$score|$total_commits|$days_span|$commits_per_day"
}

calculate_change_coverage() {
    local score=0 files_modified=0 avg_files_per_commit=0 total_commits=0
    cd "$REPO_PATH"
    total_commits=$(git rev-list --count "$BRANCH_NAME" 2>/dev/null || echo "0")
    
    [ "$total_commits" -eq 0 ] && { echo "0|0|0"; return; }
    
    files_modified=$(git diff --name-only "$BRANCH_NAME"^.."$BRANCH_NAME" 2>/dev/null | wc -l || echo "0")
    avg_files_per_commit=$((files_modified / total_commits))
    
    if [ "$avg_files_per_commit" -ge 1 ] && [ "$avg_files_per_commit" -le 10 ]; then score=100
    elif [ "$avg_files_per_commit" -gt 10 ]; then score=85
    else score=70
    fi
    echo "$score|$files_modified|$avg_files_per_commit"
}

calculate_commit_size() {
    local score=0 total_lines=0 total_commits=0 avg_lines=0 stats
    cd "$REPO_PATH"
    total_commits=$(git rev-list --count "$BRANCH_NAME" 2>/dev/null || echo "0")
    
    [ "$total_commits" -eq 0 ] && { echo "0|0|0"; return; }
    
    stats=$(git log "$BRANCH_NAME" --numstat --pretty="" 2>/dev/null | awk '{added+=$1; deleted+=$2} END {print added+deleted}')
    total_lines=${stats:-0}
    avg_lines=$((total_lines / total_commits))
    
    if [ "$avg_lines" -ge 10 ] && [ "$avg_lines" -le 1000 ]; then score=100
    elif [ "$avg_lines" -gt 1000 ]; then score=80
    else score=70
    fi
    echo "$score|$total_lines|$avg_lines"
}

calculate_merge_cleanliness() {
    local score=100 merge_commits=0 total_commits=0 penalty=0
    cd "$REPO_PATH"
    total_commits=$(git rev-list --count "$BRANCH_NAME" 2>/dev/null || echo "1")
    merge_commits=$(git rev-list "$BRANCH_NAME" --grep="Merge" 2>/dev/null | wc -l || echo "0")
    
    if [ "$merge_commits" -gt 0 ]; then
        penalty=$((merge_commits * 5))
        score=$((100 - penalty))
        score=$((score < 60 ? 60 : score))
    fi
    echo "$score|$merge_commits|$total_commits"
}

calculate_out_of_hours() {
    local late_night=0 weekend=0 after_hours=0 total=0 score=100 suspicious=0
    
    while IFS='|' read -r commit_hash commit_time _ _; do
        [ -z "$commit_hash" ] && continue
        ((total++))
        
        local hour day_of_week commit_date
        hour=$(TZ="$ECUADOR_TZ" date -d "$commit_time" +%H 2>/dev/null || echo "12")
        day_of_week=$(TZ="$ECUADOR_TZ" date -d "$commit_time" +%w 2>/dev/null || echo "3")
        commit_date=$(TZ="$ECUADOR_TZ" date -d "$commit_time" +%Y-%m-%d 2>/dev/null || echo "")
        
        [ "$commit_date" == "$EXEMPTION_DATE" ] && continue
        
        [ "$hour" -lt 5 ] && ((late_night++))
        [ "$hour" -ge 23 ] && ((after_hours++))
        { [ "$day_of_week" -eq 0 ] || [ "$day_of_week" -eq 6 ]; } && ((weekend++))
    done < "$TEMP_DIR/commits_full.txt"
    
    if [ "$total" -gt 0 ]; then
        suspicious=$((late_night + after_hours + weekend))
        score=$((100 - (suspicious * 2)))
        echo "$((score < 50 ? 50 : score))|$late_night|$after_hours|$weekend|$total"
    else
        echo "100|0|0|0|0"
    fi
}

calculate_code_integrity() {
    local score=100 issues=0 problematic_patterns
    cd "$REPO_PATH"
    problematic_patterns=$(git log "$BRANCH_NAME" --oneline 2>/dev/null | grep -icE "(wip|tmp|test|debug|fix typo)" || true)
    
    issues=${problematic_patterns:-0}
    score=$((100 - issues * 2))
    echo "$((score < 70 ? 70 : score))|$issues"
}

calculate_naming_convention() {
    local conventional=0 non_conventional=0 score=0 total=0
    
    while IFS='|' read -r commit_hash _ subject _; do
        [ -z "$commit_hash" ] && continue
        ((total++))
        if echo "$subject" | grep -qiE "^(feat|fix|docs|style|refactor|test|chore|ci|perf|build|update|add):"; then
            ((conventional++))
        else
            ((non_conventional++))
        fi
    done < "$TEMP_DIR/commits_full.txt"
    
    if [ "$total" -gt 0 ]; then
        score=$((conventional * 100 / total))
        [ "$score" -ge 50 ] && score=$((score + 10))
        echo "$((score > 100 ? 100 : score))|$conventional|$non_conventional|$total"
    else
        echo "0|0|0|0"
    fi
}

generate_json_report() {
    cat > "$1" << EOJSON
{
  "evaluacion_rubrica": {
    "fecha": "$TIMESTAMP",
    "repositorio": "$REPO_PATH",
    "rama": "$BRANCH_NAME",
    "excepciones_activas": ["$EXEMPTION_DATE"],
    "metricas": {
      "calidad_commits": $quality_score,
      "horario_commits": $time_score,
      "calidad_mensajes": $msg_score,
      "consistencia": $consistency_score,
      "cobertura_cambios": $coverage_score,
      "tamano_commits": $size_score,
      "limpieza_merges": $merge_score,
      "actividad_fuera_horas": $ooh_score,
      "integridad_codigo": $integrity_score,
      "convencion_nombres": $naming_score
    },
    "puntuacion_final": $final_score,
    "calificacion": "$rating"
  }
}
EOJSON
}

generate_html_report() {
    cat > "$1" << EOHTML
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluación Rama $BRANCH_NAME</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #2b5876 0%, #4e4376 100%); min-height: 100vh; padding: 20px; color: #333; }
        .container { max-width: 1200px; margin: 0 auto; background: white; border-radius: 10px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); overflow: hidden; }
        .header { background: linear-gradient(135deg, #2b5876 0%, #4e4376 100%); color: white; padding: 40px; text-align: center; }
        .header h1 { font-size: 2.5em; margin-bottom: 10px; }
        .header p { opacity: 0.9; font-size: 1.1em; }
        .final-score { padding: 40px; text-align: center; background: #f8f9fa; color: #333; border-bottom: 2px solid #eee; }
        .final-score h2 { font-size: 4em; margin-bottom: 10px; color: #4e4376; }
        .final-score p { font-size: 1.5em; font-weight: bold; }
        .footer { padding: 20px; background: #fff; text-align: center; color: #777; font-size: 0.9em; }
        .badge { background: #ffd700; color: #333; padding: 5px 10px; border-radius: 15px; font-size: 0.8em; font-weight: bold; margin-top: 10px; display: inline-block; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Evaluación de Rama: $BRANCH_NAME</h1>
            <p>Repositorio: $REPO_PATH</p>
            <div class="badge">Perfil de Evaluación: Tolerante</div>
        </div>
        <div class="final-score">
            <h2>$final_score / 100</h2>
            <p>$rating</p>
        </div>
        <div class="footer">
            <p>Generado el: $TIMESTAMP | Excepciones: $EXEMPTION_DATE</p>
        </div>
    </div>
</body>
</html>
EOHTML
}

run_evaluation() {
    log_header "EVALUADOR DE RAMA: $BRANCH_NAME (MODO TOLERANTE)"
    
    log_info "Validando repositorio..."
    validate_repo
    log_info "Validando rama..."
    validate_branch
    
    mkdir -p "$TEMP_DIR" "$REPORT_DIR"
    
    log_header "RECOLECTANDO DATOS"
    get_commit_data
    log_success "Datos extraídos en lote (Optimizado)"
    
    log_header "CALCULANDO MÉTRICAS REALES"
    
    quality_score=$(calculate_commit_quality)
    log_success "1. Calidad de commits: $quality_score/100"
    
    IFS='|' read -r time_score time_in_hours time_out_hours <<< "$(calculate_time_score)"
    log_success "2. Horario de commits: $time_score/100 (In: $time_in_hours, Out: $time_out_hours)"
    
    IFS='|' read -r msg_score msg_excellent msg_good msg_poor msg_total <<< "$(calculate_message_quality)"
    log_success "3. Calidad de mensajes: $msg_score/100"
    
    IFS='|' read -r consistency_score consistency_count consistency_days consistency_per_day <<< "$(calculate_consistency)"
    log_success "4. Consistencia: $consistency_score/100 (Commits/día: $consistency_per_day)"
    
    IFS='|' read -r coverage_score coverage_files coverage_avg <<< "$(calculate_change_coverage)"
    log_success "5. Cobertura de cambios: $coverage_score/100"
    
    IFS='|' read -r size_score size_total size_avg <<< "$(calculate_commit_size)"
    log_success "6. Tamaño de commits: $size_score/100 (Promedio: $size_avg líneas)"
    
    IFS='|' read -r merge_score merge_count merge_total <<< "$(calculate_merge_cleanliness)"
    log_success "7. Limpieza de merges: $merge_score/100"
    
    IFS='|' read -r ooh_score ooh_late ooh_after ooh_weekend ooh_total <<< "$(calculate_out_of_hours)"
    log_success "8. Fuera de horas: $ooh_score/100 (Omitidos los del $EXEMPTION_DATE)"
    
    IFS='|' read -r integrity_score integrity_issues <<< "$(calculate_code_integrity)"
    log_success "9. Integridad del código: $integrity_score/100"
    
    IFS='|' read -r naming_score naming_conventional naming_nonconventional naming_total <<< "$(calculate_naming_convention)"
    log_success "10. Convención de nombres: $naming_score/100"
    
    log_header "RESULTADO FINAL"
    
    local final_score=$(( 
        (quality_score * 15 + time_score * 15 + msg_score * 15 + consistency_score * 10 + coverage_score * 10 + size_score * 10 + merge_score * 5 + ooh_score * 5 + integrity_score * 10 + naming_score * 5) / 100
    ))
    
    local rating=""
    if [ "$final_score" -ge 85 ]; then rating="EXCELENTE (A)"
    elif [ "$final_score" -ge 70 ]; then rating="BUENO (B)"
    elif [ "$final_score" -ge 60 ]; then rating="REGULAR (C)"
    else rating="INSUFICIENTE (D)"
    fi
    
    echo -e "\n${MAGENTA}╔════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC}        PUNTUACIÓN FINAL: ${GREEN}$final_score/100${NC}${MAGENTA}            ║${NC}"
    echo -e "${MAGENTA}║${NC}        Calificación: ${YELLOW}$rating${NC}${MAGENTA}       ║${NC}"
    echo -e "${MAGENTA}╚════════════════════════════════════════╝${NC}\n"
    
    generate_json_report "$JSON_REPORT"
    generate_html_report "$HTML_REPORT"
    echo -e "${BLUE}Reportes guardados en:${NC} $REPORT_DIR"
    
    rm -rf "$TEMP_DIR"
}

if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    run_evaluation "$@"
fi