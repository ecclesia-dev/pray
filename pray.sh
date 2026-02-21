#!/bin/sh
# pray — Catholic prayer CLI (Rosary, Angelus, daily prayers)
# Traditional prayers only. No modernism.

set -e

VERSION="0.1.0"

# Colors (disable with NO_COLOR or TERM=dumb)
if [ -z "${NO_COLOR:-}" ] && [ "${TERM:-dumb}" != "dumb" ]; then
    BOLD=$(printf '\033[1m')
    DIM=$(printf '\033[2m')
    RESET=$(printf '\033[0m')
    GOLD=$(printf '\033[33m')
else
    BOLD="" DIM="" RESET="" GOLD=""
fi

# Day of week (1=Mon 7=Sun)
DOW_NUM=$(date "+%u")
# Month and day (for future feast day logic)
# MONTH=$(date "+%-m")
# DAY=$(date "+%-d")

hr() {
    printf '%s══════════════════════════════════════%s\n' "$GOLD" "$RESET"
}

title() {
    hr
    printf '  %s%s%s\n' "$BOLD" "$1" "$RESET"
    [ -n "${2:-}" ] && printf '  %s%s%s\n' "$DIM" "$2" "$RESET"
    hr
    printf '\n'
}

section() {
    printf '  %s── %s ──%s\n\n' "$GOLD" "$1" "$RESET"
}

prayer() {
    printf '%s\n\n' "$1" | sed 's/^/  /'
}

# ─── Prayers ────────────────────────────────────────────

sign_of_cross() {
    prayer "In the name of the Father, ✠ and of the Son, and of the Holy Ghost. Amen."
}

our_father() {
    prayer "Our Father, who art in heaven, hallowed be thy name; thy kingdom come; thy will be done on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us; and lead us not into temptation, but deliver us from evil. Amen."
}

hail_mary() {
    prayer "Hail Mary, full of grace, the Lord is with thee. Blessed art thou amongst women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen."
}

glory_be() {
    prayer "Glory be to the Father, and to the Son, and to the Holy Ghost. As it was in the beginning, is now, and ever shall be, world without end. Amen."
}

fatima_prayer() {
    prayer "O my Jesus, forgive us our sins, save us from the fires of hell, lead all souls to heaven, especially those in most need of thy mercy."
}

hail_holy_queen() {
    prayer "Hail, holy Queen, Mother of mercy, our life, our sweetness, and our hope. To thee do we cry, poor banished children of Eve. To thee do we send up our sighs, mourning and weeping in this valley of tears. Turn then, most gracious advocate, thine eyes of mercy toward us, and after this our exile, show unto us the blessed fruit of thy womb, Jesus. O clement, O loving, O sweet Virgin Mary.

℣. Pray for us, O holy Mother of God.
℟. That we may be made worthy of the promises of Christ."
}

apostles_creed() {
    prayer "I believe in God, the Father almighty, Creator of heaven and earth, and in Jesus Christ, his only Son, our Lord, who was conceived by the Holy Ghost, born of the Virgin Mary, suffered under Pontius Pilate, was crucified, died, and was buried; he descended into hell; on the third day he rose again from the dead; he ascended into heaven, and sitteth at the right hand of God the Father almighty; from thence he shall come to judge the living and the dead. I believe in the Holy Ghost, the holy Catholic Church, the communion of saints, the forgiveness of sins, the resurrection of the body, and life everlasting. Amen."
}

memorare() {
    prayer "Remember, O most gracious Virgin Mary, that never was it known that anyone who fled to thy protection, implored thy help, or sought thy intercession was left unaided. Inspired by this confidence, I fly unto thee, O Virgin of virgins, my mother; to thee do I come, before thee I stand, sinful and sorrowful. O Mother of the Word Incarnate, despise not my petitions, but in thy mercy hear and answer me. Amen."
}

st_michael() {
    prayer "Saint Michael the Archangel, defend us in battle. Be our protection against the wickedness and snares of the devil. May God rebuke him, we humbly pray; and do thou, O Prince of the heavenly host, by the power of God, cast into hell Satan, and all the evil spirits, who prowl about the world seeking the ruin of souls. Amen."
}

act_of_contrition() {
    prayer "O my God, I am heartily sorry for having offended thee, and I detest all my sins because I dread the loss of heaven and the pains of hell; but most of all because they offend thee, my God, who art all-good and deserving of all my love. I firmly resolve, with the help of thy grace, to confess my sins, to do penance, and to amend my life. Amen."
}

angelus() {
    title "The Angelus"
    prayer "℣. The Angel of the Lord declared unto Mary.
℟. And she conceived of the Holy Ghost."
    hail_mary
    prayer "℣. Behold the handmaid of the Lord.
℟. Be it done unto me according to thy word."
    hail_mary
    prayer "℣. And the Word was made flesh. (genuflect)
℟. And dwelt among us."
    hail_mary
    prayer "℣. Pray for us, O holy Mother of God.
℟. That we may be made worthy of the promises of Christ."
    section "Oremus"
    prayer "Pour forth, we beseech thee, O Lord, thy grace into our hearts; that we, to whom the incarnation of Christ, thy Son, was made known by the message of an angel, may by his passion and cross be brought to the glory of his resurrection, through the same Christ our Lord. Amen."
}

regina_caeli() {
    title "Regina Cæli" "Eastertide"
    prayer "℣. Queen of Heaven, rejoice, alleluia.
℟. For he whom thou wast made worthy to bear, alleluia.
℣. Hath risen, as he said, alleluia.
℟. Pray for us to God, alleluia.

℣. Rejoice and be glad, O Virgin Mary, alleluia.
℟. For the Lord is truly risen, alleluia."
    section "Oremus"
    prayer "O God, who through the resurrection of thy Son, our Lord Jesus Christ, didst vouchsafe to give joy to the world: grant, we beseech thee, that through his Mother, the Virgin Mary, we may obtain the joys of everlasting life. Through the same Christ our Lord. Amen."
}

# ─── Rosary ─────────────────────────────────────────────

get_mysteries() {
    case "$1" in
        joyful)
            echo "The Annunciation|The Visitation|The Nativity of Our Lord|The Presentation in the Temple|The Finding of the Child Jesus in the Temple"
            ;;
        sorrowful)
            echo "The Agony in the Garden|The Scourging at the Pillar|The Crowning with Thorns|The Carrying of the Cross|The Crucifixion and Death of Our Lord"
            ;;
        glorious)
            echo "The Resurrection|The Ascension|The Descent of the Holy Ghost|The Assumption of the Blessed Virgin Mary|The Coronation of the Blessed Virgin Mary"
            ;;
    esac
}

# Traditional mystery assignment (no luminous — that's JP2)
today_mystery() {
    case "$DOW_NUM" in
        1) echo "joyful" ;;      # Monday
        2) echo "sorrowful" ;;   # Tuesday
        3) echo "glorious" ;;    # Wednesday
        4) echo "joyful" ;;      # Thursday
        5) echo "sorrowful" ;;   # Friday
        6) echo "joyful" ;;      # Saturday
        7) echo "glorious" ;;    # Sunday
    esac
}

mystery_label() {
    case "$1" in
        joyful) echo "Joyful" ;;
        sorrowful) echo "Sorrowful" ;;
        glorious) echo "Glorious" ;;
    esac
}

print_rosary() {
    _set="${1:-$(today_mystery)}"
    _label="$(mystery_label "$_set")"
    _mysteries="$(get_mysteries "$_set")"

    title "The Most Holy Rosary" "$_label Mysteries — $(date '+%A, %B %d, %Y')"

    sign_of_cross

    section "Apostles' Creed"
    apostles_creed

    section "Introductory Prayers"
    our_father
    printf '  %s3 Hail Marys (for faith, hope, and charity)%s\n\n' "$DIM" "$RESET"
    hail_mary
    hail_mary
    hail_mary
    glory_be

    _i=1
    _IFS="$IFS"
    IFS="|"
    for _m in $_mysteries; do
        printf '\n'
        section "$(_ordinal $_i) $_label Mystery"
        printf '  %s%s%s\n\n' "$BOLD" "$_m" "$RESET"
        our_father
        printf '  %s10 Hail Marys%s\n\n' "$DIM" "$RESET"
        glory_be
        fatima_prayer
        _i=$((_i + 1))
    done
    IFS="$_IFS"

    printf '\n'
    section "Concluding Prayers"
    hail_holy_queen
    prayer "℣. O God, whose only-begotten Son, by his life, death, and resurrection, has purchased for us the rewards of eternal life: grant, we beseech thee, that by meditating upon these mysteries of the Most Holy Rosary of the Blessed Virgin Mary, we may imitate what they contain and obtain what they promise, through the same Christ our Lord. Amen."
    st_michael
    printf '\n'
    hr
}

_ordinal() {
    case "$1" in
        1) echo "First" ;; 2) echo "Second" ;; 3) echo "Third" ;;
        4) echo "Fourth" ;; 5) echo "Fifth" ;;
    esac
}

# ─── Morning/Evening Prayers ───────────────────────────

morning_offering() {
    title "Morning Offering"
    sign_of_cross
    prayer "O Jesus, through the Immaculate Heart of Mary, I offer thee my prayers, works, joys, and sufferings of this day, for all the intentions of thy Sacred Heart, in union with the Holy Sacrifice of the Mass throughout the world, in reparation for my sins, for the intentions of all my associates, and in particular for the intentions recommended by our Holy Father this month. Amen."
    section "Guardian Angel"
    prayer "Angel of God, my guardian dear, to whom God's love commits me here, ever this day be at my side, to light and guard, to rule and guide. Amen."
    st_michael
    hr
}

night_prayers() {
    title "Night Prayers"
    sign_of_cross
    section "Examination of Conscience"
    prayer "Lord, grant me the grace to see my sins clearly and to be truly sorry for them."
    section "Act of Contrition"
    act_of_contrition
    section "Guardian Angel"
    prayer "Angel of God, my guardian dear, to whom God's love commits me here, ever this night be at my side, to light and guard, to rule and guide. Amen."
    section "Sub Tuum Praesidium"
    prayer "We fly to thy patronage, O holy Mother of God; despise not our petitions in our necessities, but deliver us always from all dangers, O glorious and blessed Virgin. Amen."
    hr
}

grace_before() {
    title "Grace Before Meals"
    prayer "Bless us, O Lord, ✠ and these thy gifts, which we are about to receive from thy bounty, through Christ our Lord. Amen."
    hr
}

grace_after() {
    title "Grace After Meals"
    prayer "We give thee thanks, almighty God, for all thy benefits, who livest and reignest, world without end. Amen.

May the souls of the faithful departed, through the mercy of God, rest in peace. Amen."
    hr
}

# ─── Main ───────────────────────────────────────────────

usage() {
    cat <<EOF
pray — Catholic prayer CLI (traditional)

Usage: pray [command]

Commands:
  rosary [joyful|sorrowful|glorious]   Pray the Rosary (default: today's mysteries)
  angelus                               The Angelus
  regina                                Regina Cæli (Eastertide)
  morning                               Morning Offering
  night                                 Night Prayers
  grace                                 Grace Before Meals
  thanks                                Grace After Meals
  memorare                              The Memorare
  michael                               Prayer to St. Michael
  contrition                            Act of Contrition
  creed                                 Apostles' Creed
  list                                  List all available prayers

Without arguments, shows the Rosary for today.

Version $VERSION
EOF
}

list_prayers() {
    cat <<EOF
Available prayers:
  rosary [joyful|sorrowful|glorious]   The Most Holy Rosary
  angelus                               The Angelus
  regina                                Regina Cæli
  morning                               Morning Offering
  night                                 Night Prayers
  grace                                 Grace Before Meals
  thanks                                Grace After Meals
  memorare                              The Memorare
  michael                               Prayer to St. Michael
  contrition                            Act of Contrition
  creed                                 Apostles' Creed
EOF
}

case "${1:-rosary}" in
    rosary)     print_rosary "${2:-}" ;;
    angelus)    angelus ;;
    regina)     regina_caeli ;;
    morning)    morning_offering ;;
    night)      night_prayers ;;
    grace)      grace_before ;;
    thanks)     grace_after ;;
    memorare)   title "The Memorare"; memorare; hr ;;
    michael)    title "Prayer to St. Michael"; st_michael; hr ;;
    contrition) title "Act of Contrition"; act_of_contrition; hr ;;
    creed)      title "Apostles' Creed"; apostles_creed; hr ;;
    list)       list_prayers ;;
    -h|--help|help) usage ;;
    -v|--version) echo "pray $VERSION" ;;
    *)          usage; exit 1 ;;
esac
