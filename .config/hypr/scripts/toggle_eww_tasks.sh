#!/bin/bash

if eww active-windows | grep -q "tasks"; then
    eww close tasks
else
    eww open tasks
fi
