const fs = require('fs'); // File system module
const path = require('path'); // Path module

// Input and output directories from environment variables
const logDir = process.env.LOG_DIR || '/app/nginx_logs';
const outputDir = process.env.OUTPUT_DIR || '/app/parsed_nginx_logs';

// Regex pattern for parsing log entries
const logPattern = /^(?<ip>[\d.]+) - - \[(?<timestamp>[^\]]+)] "(?<method>\w+) (?<url>[^ ]+) (?<protocol>[^"]+)" (?<status>\d+) (?<response_size>\d+) "(?<referrer>[^"]+)" "(?<user_agent>[^"]+)"/;

try {
    // Ensure the output directory exists
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    // Read log files in the input directory
    const logFiles = fs.readdirSync(logDir).filter(file => file.endsWith('.log'));

    logFiles.forEach(logFile => {
        const inputPath = path.join(logDir, logFile);
        const outputFileName = `parsed_${logFile.replace(/\.log$/, '_log.csv')}`;
        const outputPath = path.join(outputDir, outputFileName);

        // Read and parse the log file
        const logContent = fs.readFileSync(inputPath, 'utf8');
        const lines = logContent.split('\n').filter(Boolean);

        const data = lines.map(line => {
            const match = logPattern.exec(line);
            if (match) {
                const { ip, timestamp, method, url, protocol, status, response_size, referrer, user_agent } = match.groups;
                return [ip, timestamp, method, url, protocol, status, response_size, referrer, user_agent];
            }
        }).filter(Boolean);

        // Write to CSV
        const header = 'IP,Timestamp,Method,URL,Protocol,Status,ResponseSize,Referrer,UserAgent\n';
        const csvContent = header + data.map(row => row.join(',')).join('\n');
        fs.writeFileSync(outputPath, csvContent);

        console.log(`Parsed ${logFile} -> ${outputFileName}`);
    });
} catch (err) {
    console.error(`Error: ${err.message}`);
}