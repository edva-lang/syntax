# Nushell script: Analyze system logs and format telemetry report

# Filter and aggregate request latency records
def summarize-logs [
    file_path: path
    --min-latency (-m): duration = 10ms
    --verbose (-v)
] {
    if not ($file_path | path exists) {
        error make {
            msg: $"Log file not found: ($file_path)"
            label: {
                text: "path does not exist"
                span: (metadata $file_path).span
            }
        }
    }

    let records = (
        open $file_path
        | lines
        | parse "{timestamp} [{level}] [{subsystem}] {message}"
        | where level in ["INFO", "WARN", "ERROR"]
    )

    if $verbose {
        print $"Parsed ($records | length) log entries from ($file_path)"
    }

    $records
    | group-by subsystem
    | items {|sub, entries|
        {
            subsystem: $sub
            count: ($entries | length)
            has_errors: ($entries | any {|e| $e.level == "ERROR"})
        }
    }
    | sort-by count --reverse
}

# Example invocation returning structured table
summarize-logs "system.log" --min-latency 50ms --verbose
