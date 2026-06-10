#!/bin/bash

AGE_ONE="30"
AGE_TWO="20"

if [[ "${AGE_ONE}" -gt "${AGE_TWO}" ]]; then
    echo "${AGE_ONE} is greater than ${AGE_TWO}."
else
    echo "${AGE_ONE} is less than ${AGE_TWO}."
fi