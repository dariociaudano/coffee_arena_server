package ai

import (
	"math/rand"
	"time"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

var animals = []string{
	"cat",
	"dog",
	"elephant",
	"giraffe",
	"lion",
	"monkey",
	"penguin",
	"tiger",
	"zebra",
}

var adjectives = []string{
	"awesome",
	"crazy",
	"fierce",
	"hilarious",
	"majestic",
	"playful",
	"quirky",
	"rugged",
	"spirited",
}

func GenerateNickname() string {
	rand.New(rand.NewSource(time.Now().UnixNano()))

	animalIndex := rand.Intn(len(animals))
	adjectiveIndex := rand.Intn(len(adjectives))

	c := cases.Title(language.English)
	randomAnimal := c.String(animals[animalIndex])
	randomAdjective := c.String(adjectives[adjectiveIndex])

	return randomAdjective + " " + randomAnimal
}
