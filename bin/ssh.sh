#!/usr/bin/env bash
ssh -p 8022 -o StrictHostKeyChecking=no vagrant@localhost $*
