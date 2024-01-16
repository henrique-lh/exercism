// Package weather provides tools to check the weather.
package weather

//CurrentCondition represents the current weather condition.
var CurrentCondition string

// CurrentLocation represents the current weather location. 
var CurrentLocation string

// Forecast returns the current weather condition from some city.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
