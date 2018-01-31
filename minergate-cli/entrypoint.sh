#!/bin/bash

# Composing CMD
CMD="minergate-cli"
CMD="$CMD -user $USER"
CMD="$CMD -$CURRENCY"

# Starting mining
echo "Starting mining with CMD=\"$CMD\""
eval $CMD
echo "Stopped"
