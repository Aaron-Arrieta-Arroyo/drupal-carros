<?php
header('Content-Type: text/plain');
echo "DATABASE_URL: " . ($_ENV['DATABASE_URL'] ?? 'NOT SET') . "\n";
echo "DB_HOST: " . ($_ENV['DB_HOST'] ?? 'NOT SET') . "\n";
echo "DB_PORT: " . ($_ENV['DB_PORT'] ?? 'NOT SET') . "\n";
echo "DB_NAME: " . ($_ENV['DB_NAME'] ?? 'NOT SET') . "\n";
echo "DB_USER: " . ($_ENV['DB_USER'] ?? 'NOT SET') . "\n";
echo "DB_PASSWORD: " . (isset($_ENV['DB_PASSWORD']) ? 'SET (hidden)' : 'NOT SET') . "\n";
echo "\nAll ENV keys:\n";
foreach ($_ENV as $k => $v) {
  echo "  $k = " . (strpos($k, 'PASS') !== false ? '(hidden)' : $v) . "\n";
}
