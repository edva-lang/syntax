<?php
declare(strict_types=1);

namespace App\Http;

use JsonSerializable;
use InvalidArgumentException;

readonly class ApiResponse implements JsonSerializable {
    public function __construct(
        public bool $success,
        public array $data,
        public ?string $message = null,
        public int $statusCode = 200
    ) {
        if ($this->statusCode < 100 || $this->statusCode > 599) {
            throw new InvalidArgumentException("Invalid HTTP status: {$this->statusCode}");
        }
    }

    public function jsonSerialize(): array {
        return [
            'status'    => $this->success ? 'ok' : 'error',
            'code'      => $this->statusCode,
            'message'   => $this->message,
            'data'      => $this->data,
            'timestamp' => time(),
        ];
    }
}

$resp = new ApiResponse(true, ['version' => '2.4.0'], 'Health check OK');
header('Content-Type: application/json');
echo json_encode($resp, JSON_PRETTY_PRINT);
