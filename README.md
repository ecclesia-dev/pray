# pray

**Catholic prayers from your terminal.**

`Rosary · Angelus · Morning & Night · Grace · Traditional Only · POSIX Shell`

A command-line prayer book for traditional Catholic devotions. The Rosary with proper mystery assignment, the Angelus and Regina Cæli by season, morning and night prayers, grace before and after meals, and the essential prayers every Catholic should know by heart.

No luminous mysteries. No novelties.

---

## Quick Start

```
$ pray
══════════════════════════════════════
  The Holy Rosary — Sorrowful Mysteries
  Friday, February 20, 2026
══════════════════════════════════════

  ✠ In the name of the Father, and of
  the Son, and of the Holy Ghost. Amen.

  I believe in God, the Father Almighty,
  Creator of heaven and earth...
```

## Installation

```sh
git clone https://github.com/ecclesia-dev/pray.git
cd pray
make install
```

To uninstall:

```sh
make uninstall
```

## Usage

```
pray [prayer] [option]
```

### Prayers

```sh
$ pray                       # Rosary (today's mysteries)
$ pray rosary sorrowful      # specific mysteries
$ pray angelus               # Angelus (or Regina Cæli in Eastertide)
$ pray morning               # Morning Offering with Guardian Angel & St. Michael
$ pray night                 # Night Prayers with Examination of Conscience
$ pray grace                 # Grace Before Meals
$ pray thanks                # Grace After Meals
$ pray memorare              # The Memorare
$ pray michael               # Prayer to St. Michael
$ pray contrition            # Act of Contrition
$ pray creed                 # Apostles' Creed
$ pray list                  # show all available prayers
```

### Mystery Assignment

| Day | Mysteries |
|-----|-----------|
| Sunday | Glorious |
| Monday | Joyful |
| Tuesday | Sorrowful |
| Wednesday | Joyful |
| Thursday | Joyful |
| Friday | Sorrowful |
| Saturday | Glorious |

### Piping

```sh
pray rosary | say -v Daniel    # read aloud (macOS)
pray night | less               # page through
```

## Requirements

POSIX shell. No dependencies.

## Related Projects

| Tool | Description |
|------|-------------|
| **[drb](https://github.com/ecclesia-dev/drb)** | Douay-Rheims Bible with Haydock commentary |
| **[opus](https://github.com/ecclesia-dev/opus)** | Traditional Divine Office (1962 Breviary) |
| **[rosary-ios](https://github.com/ecclesia-dev/rosary-ios)** | Holy Rosary for iPhone |

## License

Public domain.

---
_Built by Jerome. Reviewed by Bellarmine (theology) and Pius (content alignment)._
