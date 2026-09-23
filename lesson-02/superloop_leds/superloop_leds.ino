// Superloop: 3 independent LED tasks in one loop()
// LED1: 200 ms, LED2: 500 ms, LED3: 1000 ms
// No delay(), no waiting while() in loop(). Timing via millis().

const int LED1_PIN = 8;
const int LED2_PIN = 9;
const int LED3_PIN = 10;

const unsigned long LED1_INTERVAL_MS = 200;
const unsigned long LED2_INTERVAL_MS = 500;
const unsigned long LED3_INTERVAL_MS = 1000;

unsigned long led1LastMs = 0;
unsigned long led2LastMs = 0;
unsigned long led3LastMs = 0;

bool led1On = false;
bool led2On = false;
bool led3On = false;

void setup() {
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
  pinMode(LED3_PIN, OUTPUT);

  digitalWrite(LED1_PIN, LOW);
  digitalWrite(LED2_PIN, LOW);
  digitalWrite(LED3_PIN, LOW);
}

void loop() {
  unsigned long now = millis();

  if (now - led1LastMs >= LED1_INTERVAL_MS) {
    led1LastMs = now;
    led1On = !led1On;
    digitalWrite(LED1_PIN, led1On ? HIGH : LOW);
  }

  if (now - led2LastMs >= LED2_INTERVAL_MS) {
    led2LastMs = now;
    led2On = !led2On;
    digitalWrite(LED2_PIN, led2On ? HIGH : LOW);
  }

  if (now - led3LastMs >= LED3_INTERVAL_MS) {
    led3LastMs = now;
    led3On = !led3On;
    digitalWrite(LED3_PIN, led3On ? HIGH : LOW);
  }
}
