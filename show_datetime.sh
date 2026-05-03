#!/bin/bash

echo "=== Current Date and Time in Different Formats ==="
echo

# 1. Default format (locale-dependent)
echo "1. Default format:"
date
echo

# 2. ISO 8601 format (YYYY-MM-DD HH:MM:SS)
echo "2. ISO 8601 format:"
date +"%Y-%m-%d %H:%M:%S"
echo

# 3. ISO 8601 with timezone
echo "3. ISO 8601 with timezone:"
date +"%Y-%m-%dT%H:%M:%S%z"
echo

# 4. US format (MM/DD/YYYY)
echo "4. US format (MM/DD/YYYY):"
date +"%m/%d/%Y %I:%M:%S %p"
echo

# 5. European format (DD/MM/YYYY)
echo "5. European format (DD/MM/YYYY):"
date +"%d/%m/%Y %H:%M:%S"
echo

# 6. Full weekday and month names
echo "6. Full format with names:"
date +"%A, %B %d, %Y at %I:%M:%S %p"
echo

# 7. Unix timestamp (seconds since epoch)
echo "7. Unix timestamp:"
date +%s
echo

# 8. RFC 2822 format (used in email headers)
echo "8. RFC 2822 format:"
date -R
echo

# 9. Custom format with day of year
echo "9. Custom format (Day of year):"
date +"%Y-%m-%d is day %j of the year"
echo

# 10. 24-hour vs 12-hour format
echo "10. Time formats comparison:"
echo "   24-hour: $(date +"%H:%M:%S")"
echo "   12-hour: $(date +"%I:%M:%S %p")"
echo

# 11. Week number formats
echo "11. Week numbers:"
echo "   Week of year (Sunday as first day): $(date +"%U")"
echo "   Week of year (Monday as first day): $(date +"%W")"
echo "   ISO week number: $(date +"%V")"
echo

# 12. Get current timezone
echo "12. Current timezone:"
date +"%Z (%z)"
