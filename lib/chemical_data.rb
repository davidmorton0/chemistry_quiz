module ChemicalData
  ELEMENT = [
    {
      ar: 1,
      name: 'Hydrogen',
      symbol: 'H',
      group: 1,
      period: 1,
      block: 's',
      state: 'Gas',
      description: 'Non-metal'
    },
    {
      ar: 2,
      name: 'Helium',
      symbol: 'He',
      group: 18,
      period: 1,
      block: 's',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 3,
      name: 'Lithium',
      symbol: 'Li',
      group: 1,
      period: 2,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 4,
      name: 'Beryllium',
      symbol: 'Be',
      group: 2,
      period: 2,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 5,
      name: 'Boron',
      symbol: 'B',
      group: 13,
      period: 2,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 6,
      name: 'Carbon',
      symbol: 'C',
      group: 14,
      period: 2,
      block: 'p',
      state: 'Solid',
      description: 'Non-metal'
    },
    {
      ar: 7,
      name: 'Nitrogen',
      symbol: 'N',
      group: 15,
      period: 2,
      block: 'p',
      state: 'Gas',
      description: 'Non-metal'
    },
    {
      ar: 8,
      name: 'Oxygen',
      symbol: 'O',
      group: 16,
      period: 2,
      block: 'p',
      state: 'Gas',
      description: 'Non-metal'
    },
    {
      ar: 9,
      name: 'Fluorine',
      symbol: 'F',
      group: 17,
      period: 2,
      block: 'p',
      state: 'Gas',
      description: 'Halogen'
    },
    {
      ar: 10,
      name: 'Neon',
      symbol: 'Ne',
      group: 18,
      period: 2,
      block: 'p',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 11,
      name: 'Sodium',
      symbol: 'Na',
      group: 1,
      period: 3,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 12,
      name: 'Magnesium',
      symbol: 'Mg',
      group: 2,
      period: 3,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 13,
      name: 'Aluminium',
      symbol: 'Al',
      group: 13,
      period: 3,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 14,
      name: 'Silicon',
      symbol: 'Si',
      group: 14,
      period: 3,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 15,
      name: 'Phosphorus',
      symbol: 'P',
      group: 15,
      period: 3,
      block: 'p',
      state: 'Solid',
      description: 'Non-metal'
    },
    {
      ar: 16,
      name: 'Sulfur',
      symbol: 'S',
      group: 16,
      period: 3,
      block: 'p',
      state: 'Solid',
      description: 'Non-metal'
    },
    {
      ar: 17,
      name: 'Chlorine',
      symbol: 'Cl',
      group: 17,
      period: 3,
      block: 'p',
      state: 'Gas',
      description: 'Halogen'
    },
    {
      ar: 18,
      name: 'Argon',
      symbol: 'ar',
      group: 18,
      period: 3,
      block: 'p',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 19,
      name: 'Potassium',
      symbol: 'K',
      group: 1,
      period: 4,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 20,
      name: 'Calcium',
      symbol: 'Ca',
      group: 2,
      period: 4,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 21,
      name: 'Scandium',
      symbol: 'Sc',
      group: 3,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 22,
      name: 'Titanium',
      symbol: 'Ti',
      group: 4,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 23,
      name: 'Vanadium',
      symbol: 'V',
      group: 5,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 24,
      name: 'Chromium',
      symbol: 'Cr',
      group: 6,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 25,
      name: 'Manganese',
      symbol: 'Mn',
      group: 7,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 26,
      name: 'Iron',
      symbol: 'Fe',
      group: 8,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 27,
      name: 'Cobalt',
      symbol: 'Co',
      group: 9,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 28,
      name: 'Nickel',
      symbol: 'Ni',
      group: 10,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 29,
      name: 'Copper',
      symbol: 'Cu',
      group: 11,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 30,
      name: 'Zinc',
      symbol: 'Zn',
      group: 12,
      period: 4,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 31,
      name: 'Gallium',
      symbol: 'Ga',
      group: 13,
      period: 4,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 32,
      name: 'Germanium',
      symbol: 'Ge',
      group: 14,
      period: 4,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 33,
      name: 'Arsenic',
      symbol: 'As',
      group: 15,
      period: 4,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 34,
      name: 'Selenium',
      symbol: 'Se',
      group: 16,
      period: 4,
      block: 'p',
      state: 'Solid',
      description: 'Non-metal'
    },
    {
      ar: 35,
      name: 'Bromine',
      symbol: 'Br',
      group: 17,
      period: 4,
      block: 'p',
      state: 'Liquid',
      description: 'Halogen'
    },
    {
      ar: 36,
      name: 'Krypton',
      symbol: 'Kr',
      group: 18,
      period: 4,
      block: 'p',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 37,
      name: 'Rubidium',
      symbol: 'Rb',
      group: 1,
      period: 5,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 38,
      name: 'Strontium',
      symbol: 'Sr',
      group: 2,
      period: 5,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 39,
      name: 'Yttrium',
      symbol: 'Y',
      group: 3,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 40,
      name: 'Zirconium',
      symbol: 'Zr',
      group: 4,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 41,
      name: 'Niobium',
      symbol: 'Nb',
      group: 5,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 42,
      name: 'Molybdenum',
      symbol: 'Mo',
      group: 6,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 43,
      name: 'Technetium',
      symbol: 'Tc',
      group: 7,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 44,
      name: 'Ruthenium',
      symbol: 'Ru',
      group: 8,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 45,
      name: 'Rhodium',
      symbol: 'Rh',
      group: 9,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 46,
      name: 'Palladium',
      symbol: 'Pd',
      group: 10,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 47,
      name: 'Silver',
      symbol: 'Ag',
      group: 11,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 48,
      name: 'Cadmium',
      symbol: 'Cd',
      group: 12,
      period: 5,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 49,
      name: 'Indium',
      symbol: 'In',
      group: 13,
      period: 5,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 50,
      name: 'Tin',
      symbol: 'Sn',
      group: 14,
      period: 5,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 51,
      name: 'Antimony',
      symbol: 'Sb',
      group: 15,
      period: 5,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 52,
      name: 'Tellurium',
      symbol: 'Te',
      group: 16,
      period: 5,
      block: 'p',
      state: 'Solid',
      description: 'Metalloid'
    },
    {
      ar: 53,
      name: 'Iodine',
      symbol: 'I',
      group: 17,
      period: 5,
      block: 'p',
      state: 'Solid',
      description: 'Halogen'
    },
    {
      ar: 54,
      name: 'Xenon',
      symbol: 'Xe',
      group: 18,
      period: 5,
      block: 'p',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 55,
      name: 'Caesium',
      symbol: 'Cs',
      group: 1,
      period: 6,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 56,
      name: 'Barium',
      symbol: 'Ba',
      group: 2,
      period: 6,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 57,
      name: 'Lanthanum',
      symbol: 'La',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 58,
      name: 'Cerium',
      symbol: 'Ce',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 59,
      name: 'Praseodymium',
      symbol: 'Pr',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 60,
      name: 'Neodymium',
      symbol: 'Nd',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 61,
      name: 'Promethium',
      symbol: 'Pm',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 62,
      name: 'Samarium',
      symbol: 'Sm',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 63,
      name: 'Europium',
      symbol: 'Eu',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 64,
      name: 'Gadolinium',
      symbol: 'Gd',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 65,
      name: 'Terbium',
      symbol: 'Tb',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 66,
      name: 'Dysprosium',
      symbol: 'Dy',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 67,
      name: 'Holmium',
      symbol: 'Ho',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 68,
      name: 'Erbium',
      symbol: 'Er',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 69,
      name: 'Thulium',
      symbol: 'Tm',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 70,
      name: 'Ytterbium',
      symbol: 'Yb',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 71,
      name: 'Lutetium',
      symbol: 'Lu',
      group: 3,
      period: 6,
      block: 'f',
      state: 'Solid',
      description: 'Lanthanide'
    },
    {
      ar: 72,
      name: 'Hafnium',
      symbol: 'Hf',
      group: 4,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 73,
      name: 'Tantalum',
      symbol: 'Ta',
      group: 5,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 74,
      name: 'Tungsten',
      symbol: 'W',
      group: 6,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 75,
      name: 'Rhenium',
      symbol: 'Re',
      group: 7,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 76,
      name: 'Osmium',
      symbol: 'Os',
      group: 8,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 77,
      name: 'Iridium',
      symbol: 'Ir',
      group: 9,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 78,
      name: 'Platinum',
      symbol: 'Pt',
      group: 10,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 79,
      name: 'Gold',
      symbol: 'Au',
      group: 11,
      period: 6,
      block: 'd',
      state: 'Solid',
      description: 'Transition metal'
    },
    {
      ar: 80,
      name: 'Mercury',
      symbol: 'Hg',
      group: 12,
      period: 6,
      block: 'd',
      state: 'Liquid',
      description: 'Transition metal'
    },
    {
      ar: 81,
      name: 'Thallium',
      symbol: 'Tl',
      group: 13,
      period: 6,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 82,
      name: 'Lead',
      symbol: 'Pb',
      group: 14,
      period: 6,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 83,
      name: 'Bismuth',
      symbol: 'Bi',
      group: 15,
      period: 6,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 84,
      name: 'Polonium',
      symbol: 'Po',
      group: 16,
      period: 6,
      block: 'p',
      state: 'Solid',
      description: 'Metal'
    },
    {
      ar: 85,
      name: 'Astatine',
      symbol: 'At',
      group: 17,
      period: 6,
      block: 'p',
      state: 'Solid',
      description: 'Halogen'
    },
    {
      ar: 86,
      name: 'Radon',
      symbol: 'Rn',
      group: 18,
      period: 6,
      block: 'p',
      state: 'Gas',
      description: 'Noble gas'
    },
    {
      ar: 87,
      name: 'Francium',
      symbol: 'Fr',
      group: 1,
      period: 7,
      block: 's',
      state: 'Solid',
      description: 'Alkali metal'
    },
    {
      ar: 88,
      name: 'Radium',
      symbol: 'Ra',
      group: 2,
      period: 7,
      block: 's',
      state: 'Solid',
      description: 'Alkaline earth metal'
    },
    {
      ar: 89,
      name: 'Actinium',
      symbol: 'Ac',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 90,
      name: 'Thorium',
      symbol: 'Th',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 91,
      name: 'Protactinium',
      symbol: 'Pa',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 92,
      name: 'Uranium',
      symbol: 'U',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 93,
      name: 'Neptunium',
      symbol: 'Np',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 94,
      name: 'Plutonium',
      symbol: 'Pu',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 95,
      name: 'Americium',
      symbol: 'Am',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 96,
      name: 'Curium',
      symbol: 'Cm',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 97,
      name: 'Berkelium',
      symbol: 'Bk',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 98,
      name: 'Californium',
      symbol: 'Cf',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 99,
      name: 'Einsteinium',
      symbol: 'Es',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 100,
      name: 'Fermium',
      symbol: 'Fm',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 101,
      name: 'Mendelevium',
      symbol: 'Md',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 102,
      name: 'Nobelium',
      symbol: 'No',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Solid',
      description: 'Actinide'
    },
    {
      ar: 103,
      name: 'Lawrencium',
      symbol: 'Lr',
      group: 3,
      period: 7,
      block: 'f',
      state: 'Unknown',
      description: 'Actinide'
    },
    {
      ar: 104,
      name: 'Rutherfordium',
      symbol: 'Rf',
      group: 4,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 105,
      name: 'Dubnium',
      symbol: 'Db',
      group: 5,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 106,
      name: 'Seaborgium',
      symbol: 'Sg',
      group: 6,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 107,
      name: 'Bohrium',
      symbol: 'Bh',
      group: 7,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 108,
      name: 'Hassium',
      symbol: 'Hs',
      group: 8,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 109,
      name: 'Meitnerium',
      symbol: 'Mt',
      group: 9,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 110,
      name: 'Darmstadtium',
      symbol: 'Ds',
      group: 10,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 111,
      name: 'Roentgenium',
      symbol: 'Rg',
      group: 11,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 112,
      name: 'Copernicium',
      symbol: 'Cn',
      group: 12,
      period: 7,
      block: 'd',
      state: 'Unknown',
      description: 'Transition metal'
    },
    {
      ar: 113,
      name: 'Nihonium',
      symbol: 'Nh',
      group: 13,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metalloid'
    },
    {
      ar: 114,
      name: 'Flerovium',
      symbol: 'Fl',
      group: 14,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metalloid'
    },
    {
      ar: 115,
      name: 'Moscovium',
      symbol: 'Mc',
      group: 15,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metal'
    },
    {
      ar: 116,
      name: 'Livermorium',
      symbol: 'Lv',
      group: 16,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metal'
    },
    {
      ar: 117,
      name: 'Tennessine',
      symbol: 'Ts',
      group: 17,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metal'
    },
    {
      ar: 118,
      name: 'Oganesson',
      symbol: 'Og',
      group: 18,
      period: 7,
      block: 'p',
      state: 'Unknown',
      description: 'Metalloid'
    },
  ]
  SUBSTANCE = [
    {
      name: 'Hydrogen',
      mr: 2,
      formula: 'H2',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Helium',
      mr: 4,
      formula: 'He',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Atom',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Lithium',
      mr: 6.9,
      formula: 'Li',
      state: 'Solid',
      colour: 'Silvery-white',
      type: 'Element',
      entity: 'Metal',
      bonding: 'Metallic'
    },
    {
      name: 'Carbon (diamond)',
      mr: 12,
      formula: 'C (diamond)',
      state: 'Solid',
      colour: 'Black',
      type: 'Element',
      entity: 'Giant Molecule',
      bonding: 'Giant Molecular'
    },
    {
      name: 'Carbon (graphite)',
      mr: 12,
      formula: 'C (graphite)',
      state: 'Solid',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Giant Molecule',
      bonding: 'Giant Molecular'
    },
    {
      name: 'Nitrogen',
      mr: 28,
      formula: 'N2',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Oxygen',
      mr: 32,
      formula: 'O2',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Fluorine',
      mr: 34.0,
      formula: 'F2',
      state: 'Gas',
      colour: 'Very pale yellow',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Neon',
      mr: 20.2,
      formula: 'Ne',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Atom',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Sodium',
      mr: 23.0,
      formula: 'Na',
      state: 'Solid',
      colour: 'Silvery-white',
      type: 'Element',
      entity: 'Metal',
      bonding: 'Metallic'
    },
    {
      name: 'Magnesium',
      mr: 24.3,
      formula: 'Mg',
      state: 'Solid',
      colour: 'Shiny Grey',
      type: 'Element',
      entity: 'Metal',
      bonding: 'Metallic'
    },
    {
      name: 'Aluminium',
      mr: 27.0,
      formula: 'Al',
      state: 'Solid',
      colour: 'Silvery-grey',
      type: 'Element',
      entity: 'Metal',
      bonding: 'Metallic'
    },
    {
      name: 'Silicon',
      mr: 14,
      formula: 'Si',
      state: 'Solid',
      colour: 'Shiny blue-grey',
      type: 'Element',
      entity: 'Giant Molecule',
      bonding: 'Giant Molecular'
    },
    {
      name: 'Phosphorus',
      mr: 123.9,
      formula: 'P4',
      state: 'Solid',
      colour: 'Red',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Sulphur',
      mr: 256.5,
      formula: 'S8',
      state: 'Solid',
      colour: 'Yellow',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Chlorine',
      mr: 70.9,
      formula: 'H2O',
      state: 'Gas',
      colour: 'Yellow-green',
      type: 'Element',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Argon',
      mr: 39.8,
      formula: 'Ar',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Element',
      entity: 'Atom',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Methane',
      mr: 16,
      formula: 'CH4',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Ammonia',
      mr: 17,
      formula: 'NH3',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Water',
      mr: 18,
      formula: 'H2O',
      state: 'Liquid',
      colour: 'Colourless',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Hydrogen fluoride',
      mr: 20.0,
      formula: 'HF',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Sodium oxide',
      mr: 62.0,
      formula: 'Na2O',
      state: 'Solid',
      colour: 'White',
      type: 'Compound',
      entity: 'Ionic',
      bonding: 'Ionic'
    },
    {
      name: 'Magnesium oxide',
      mr: 40.3,
      formula: 'MgO',
      state: 'Solid',
      colour: 'White',
      type: 'Compound',
      entity: 'Ionic',
      bonding: 'Ionic'
    },
    {
      name: 'Aluminium oxide',
      mr: 102.0,
      formula: 'Al2O3',
      state: 'Solid',
      colour: 'White',
      type: 'Compound',
      entity: 'Ionic',
      bonding: 'Ionic'
    },
    {
      name: 'Carbon dioxide',
      mr: 44.0,
      formula: 'CO2',
      state: 'Gas',
      colour: 'Colourless',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    },
    {
      name: 'Nitrogen dioxide',
      mr: 46.0,
      formula: 'NO2',
      state: 'Gas',
      colour: 'Red-brown',
      type: 'Compound',
      entity: 'Molecule',
      bonding: 'Simple Molecular'
    }
  ]
  FAKENAMES = [
    "Acoustium",
    "Adamantine",
    "Adamantite",
    "Administratium",
    "Aether",
    "Aetherium",
    "Afraidium",
    "Agricite",
    "Alkahest",
    "Amazonium",
    "Arcanite",
    "Arenak",
    "Arsonium",
    "Atium",
    "Atmosphereum",
    "Australium",
    "Axonite",
    "Balthazate",
    "Balthorium",
    "Basidiumite",
    "Bavarium",
    "Bazoolium",
    "Beerium",
    "Bendezium",
    "Beresium",
    "Bernalium",
    "Bigon",
    "Blingidium",
    "Bogon",
    "Bolonium",
    "Bombastium",
    "Boojum",
    "Bureaucratium",
    "Byzanium",
    "Calculon",
    "Capitalium",
    "Capsidium",
    "Carbonadium",
    "Carbonite",
    "Carmot",
    "Cavorite",
    "Chelonium",
    "Chlorophyte",
    "Chromedigizoid",
    "Chronoton",
    "Cluon",
    "Collapsium",
    "Computronium",
    "Corbomite",
    "Corrodium",
    "Cortenum",
    "Dagal",
    "Dalekanium",
    "Deflagrator",
    "Deletium",
    "Destronium",
    "Diamondillium",
    "Diamondium",
    "Dilithium",
    "Disgruntium",
    "Divinium",
    "Dragonbane",
    "Duetronium",
    "Duranium",
    "Durium",
    "Dust",
    "Ekti",
    "Elementium",
    "Elephantanium",
    "Elephantigen",
    "Elerium",
    "Endurium",
    "Energon",
    "Eridium",
    "Eternium",
    "Etherium",
    "Explodium",
    "Faidon",
    "Feminum",
    "Finkilium",
    "Frinkonium",
    "Froonium",
    "Fulgarator",
    "Galine",
    "Grimacite",
    "Gundanium",
    "Handwavium",
    "Harbenite",
    "Hedonium",
    "Hellion",
    "Hikouseki",
    "Illudium",
    "Illyrion",
    "Impervium",
    "Imulsion",
    "Inerton",
    "Infernium",
    "Inoson",
    "Isogen",
    "Japanium",
    "Jerktonium",
    "Jethrik",
    "Jezz",
    "Jouronium",
    "Jumbonium",
    "Kairoseki",
    "Katchin",
    "Kingon",
    "Kironide",
    "Kryptonite",
    "Laconia",
    "Latinum",
    "Lerasium",
    "Lux",
    "Maclarium",
    "Magicite",
    "Maracite",
    "Marvelium",
    "Megacyte",
    "Meowium",
    "Meteorillium",
    "Mexallon",
    "Mithril",
    "Mizzium",
    "Monopasium",
    "Moonsilver",
    "Morphite",
    "Nanite",
    "Naqahdah",
    "Naquadriah",
    "Narrativium",
    "Necrodermis",
    "Necrogen",
    "Necronium",
    "Neoteutonium",
    "Neutronium",
    "Neutrotope",
    "Nitrium",
    "Nocxium",
    "Nucleoproton",
    "Nuridium",
    "Nvidium",
    "Octiron",
    "Octogen",
    "Omega",
    "Onnesium",
    "Orichalcum",
    "Oxyale",
    "Oz",
    "Padillium",
    "Pergium",
    "Phazon",
    "Philosophon",
    "Philote",
    "Phlogiston",
    "Phostlite",
    "Photonium",
    "Plutonite",
    "Polydenum",
    "Primium",
    "Promethium",
    "Protonite",
    "Psitanium",
    "Pyerite",
    "Pym",
    "Pyreal",
    "Quadium",
    "Quantium",
    "Quassium B",
    "Queon",
    "Randomonium",
    "Redstone",
    "Regalite",
    "Relux",
    "Reson",
    "Runite",
    "Sakuradite",
    "Sanite",
    "Saronite",
    "Schwartz",
    "Scrith",
    "Shazamium",
    "Silverstone",
    "Sinisite",
    "Sivanium",
    "Smitherene",
    "Snark",
    "Solenite",
    "Solium",
    "Soulsteel",
    "Strongium 90",
    "Stupidium",
    "Stygium",
    "Supermanium",
    "Tachyon",
    "Taydenite",
    "Thaesium",
    "Thaum",
    "Thiotimoline",
    "Thorium",
    "Thyrium",
    "Tibanna",
    "Tiberium",
    "Timonium",
    "Transformium",
    "Transparent aluminum",
    "Trilithium",
    "Trinium",
    "Tritanium",
    "Tronium",
    "Truthitonium",
    "Turbidium",
    "Turbonium",
    "Tylium",
    "Unobtainium",
    "Unobtanium",
    "Upsidaisium",
    "Uridium",
    "Uru",
    "Verterium",
    "Vibranium",
    "Vionesium",
    "Vizorium",
    "Volucite",
    "Warpstone",
    "Wellstone",
    "Wishalloy",
    "Wonderflonium",
    "Xenothium",
    "Xentronium",
    "Xirdalium",
    "Xithricite",
    "Yuanon",
    "Zexonite",
    "Zfylud",
    "Zoridium",
    "Zuunium",
    "Zydrine",
    ]
  NAMES = (ELEMENT.map { |s| s[:name] } + SUBSTANCE.map { |s| s[:name] } + FAKENAMES).uniq
end