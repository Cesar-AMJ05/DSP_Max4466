#include <stdio.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include "driver/gpio.h"
#include "driver/adc.h"
#include <HardwareSerial.h>

#define ANALOG_PIN GPIO_NUM_15 // GPIO 15
#define tms 25

float sensitivity = 58.0 / 1000.0; // Sensibilidad del micrófono mV/Pa

int v_bit = 0;
unsigned long Time_Init = 0;
float sensorValue;

void setup() {
  Serial.begin(115200);
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_0, ADC_ATTEN_DB_11);
  
}

void loop() {
  sensorValue = analogRead(ANALOG_PIN);
  float voltage = (sensorValue / 4095.0) * 3.3;
  Serial.println(voltage);
  
  delay(tms); // Agrega un retardo si es necesario
}
