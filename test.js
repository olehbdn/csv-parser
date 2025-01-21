const fs = require('fs'); // Import the File System module

// Input and output files
const logFile = 'nginx.log'; // Replace with your log file
const csvFile = 'parsed_nginx_log.csv'; // Replace with your desired output file

// Regex pattern for parsing log entries
const logPattern = /^(?<ip>[\d.]+) - - \[(?<timestamp>[^\]]+)] "(?<method>\w+) (?<url>[^ ]+) (?<protocol>[^"]+)" (?<status>\d+) (?<response_size>\d+) "(?<referrer>[^"]+)" "(?<user_agent>[^"]+)"/;

// Read the log file
const logContent = fs.readFileSync(logFile, 'utf8'); // Read file synchronously as a UTF-8 string
const lines = logContent.split('\n').filter(Boolean); // Remove empty lines

// Parse each line into an array of objects
const data = lines.map((line) => {
    const match = logPattern.exec(line);
    if (match) {
        const { ip, timestamp, method, url, protocol, status, response_size, referrer, user_agent } = match.groups;
        return [ip, timestamp, method, url, protocol, status, response_size, referrer, user_agent];
    }
}).filter(Boolean); // Filter out any undefined values

// Prepare CSV content
const header = 'IP,Timestamp,Method,URL,Protocol,Status,ResponseSize,Referrer,UserAgent\n';
const csvContent = header + data.map(row => row.join(',')).join('\n');

// Write CSV content to file
fs.writeFileSync(csvFile, csvContent);
console.log(`Log data successfully written to ${csvFile}`);
