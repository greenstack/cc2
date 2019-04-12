return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 33,
  height = 27,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 16,
  nextobjectid = 44,
  properties = {},
  tilesets = {
    {
      name = "city",
      firstgid = 1,
      filename = "city.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "../img/tiles.png",
      imagewidth = 320,
      imageheight = 320,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 100,
      tiles = {}
    },
    {
      name = "pathingGraph",
      firstgid = 101,
      filename = "pathingGraph.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 6,
      image = "../img/graphbase.png",
      imagewidth = 192,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 6,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 12,
      name = "ground_layer",
      x = 0,
      y = 0,
      width = 33,
      height = 27,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 12, 1, 1, 1, 1, 91, 92, 91, 91, 1, 1, 1, 91, 91, 92, 91, 1, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 12, 1, 1, 1, 1, 1, 22, 1, 1, 1, 1, 1, 1, 1, 22, 1, 1, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 12, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 17, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 16, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        21, 21, 21, 21, 21, 4, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 1, 4, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 9, 20, 10, 10, 10, 10, 10, 20, 10, 10, 10, 20, 19, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        71, 71, 71, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 8, 1, 5, 6, 6, 6,
        71, 71, 71, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 62, 63, 1, 1, 1, 1, 71, 71, 71, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        81, 81, 81, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 74, 75, 1, 1, 1, 3, 71, 71, 71, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        92, 91, 91, 1, 1, 5, 6, 6, 6, 6, 8, 1, 1, 93, 94, 1, 1, 1, 3, 81, 81, 81, 5, 6, 6, 6, 6, 7, 1, 4, 6, 6, 6,
        1, 22, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 22, 1, 1, 1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        15, 15, 15, 15, 15, 17, 26, 26, 26, 26, 18, 14, 15, 15, 15, 15, 15, 14, 15, 15, 15, 15, 17, 26, 26, 26, 26, 7, 21, 5, 26, 26, 26,
        6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 16, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 27, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 27, 6, 6, 6, 6, 8, 1, 5, 6, 6, 6,
        10, 10, 10, 20, 10, 19, 26, 26, 26, 26, 9, 10, 10, 10, 20, 10, 10, 10, 10, 20, 10, 10, 19, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 62, 63, 62, 63, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 62, 63, 62, 63, 5, 6, 6, 6, 6, 7, 1, 4, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 72, 73, 72, 73, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 82, 82, 82, 82, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 16,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 82, 82, 82, 82, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 91, 91, 92, 91, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6,
        1, 1, 1, 1, 1, 5, 6, 6, 6, 6, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 22, 1, 5, 6, 6, 6, 6, 7, 1, 5, 6, 6, 6
      }
    },
    {
      type = "tilelayer",
      id = 13,
      name = "decorations",
      x = 0,
      y = 0,
      width = 33,
      height = 27,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 32, 0, 0, 0, 0, 0, 46, 47, 0, 0, 0, 0, 48, 47, 47, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        31, 31, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 41, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 42, 0,
        0, 66, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 96, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 42, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 41, 0, 0, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0,
        0, 32, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 43, 25, 0, 32, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 96, 0, 0, 96, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 42,
        24, 31, 34, 31, 35, 0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 36, 0,
        32, 0, 32, 0, 45, 0, 41, 0, 0, 0, 0, 0, 0, 0, 23, 31, 31, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        45, 0, 32, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      id = 6,
      name = "collisions",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 417.5,
          y = 289,
          width = 63,
          height = 94,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576.5,
          y = 298,
          width = 30.5,
          height = 85.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608.697,
          y = 286.603,
          width = 94.6981,
          height = 97.714,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576.729,
          y = 638.855,
          width = 126.063,
          height = 191.079,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 43.25,
          y = 704.375,
          width = 9.25,
          height = 63.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 52.5,
          y = 747.125,
          width = 32.25,
          height = 20.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 74.875,
          y = 767.625,
          width = 10.25,
          height = 96.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 139,
          y = 736.125,
          width = 9.875,
          height = 95.625,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 811.125,
          width = 10.875,
          height = 20.375,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 85.125,
          y = 778.75,
          width = 53.75,
          height = 21.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = -0.125,
          y = 778.875,
          width = 75,
          height = 21.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 11,
          y = 800.125,
          width = 9.875,
          height = 63.875,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = -0.25,
          y = 842.75,
          width = 11.375,
          height = 21.125,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 458.875,
          y = 810.5,
          width = 10,
          height = 53.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 469,
          y = 811,
          width = 107,
          height = 21,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = -0.5,
          y = 42.5,
          width = 85.25,
          height = 21.25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 75,
          y = -0.25,
          width = 9.75,
          height = 43,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 0,
          width = 448,
          height = 31.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 101.091,
          y = 134,
          width = 27.2727,
          height = 25.4545,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 98.7273,
          y = 196.364,
          width = 26.9091,
          height = 26.5455,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = -3,
          y = 254,
          width = 99.6667,
          height = 129.667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 453.667,
          y = 644.333,
          width = 22,
          height = 26,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 483,
          y = 678.333,
          width = 26.6667,
          height = 25.3333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 294.333,
          y = 710.667,
          width = 25,
          height = 23.3333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 258.667,
          y = 743,
          width = 26.3333,
          height = 24.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 229.667,
          y = 775.333,
          width = 27.6667,
          height = 22.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 194.667,
          y = 805.667,
          width = 26,
          height = 25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 387.333,
          y = 453.333,
          width = 26.6667,
          height = 25.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 420.667,
          y = 486.333,
          width = 24.6667,
          height = 24.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 900,
          y = 612.667,
          width = 26.6667,
          height = 89.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 965.667,
          y = 295,
          width = 57.6667,
          height = 25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 963,
          y = 134.667,
          width = 57.6667,
          height = 25,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = -14,
          y = -24,
          width = 1087,
          height = 23,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = -43,
          y = -9,
          width = 42,
          height = 892,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = -15,
          y = 863,
          width = 1090,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1056,
          y = -23,
          width = 34,
          height = 890,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      id = 14,
      name = "high",
      x = 0,
      y = 0,
      width = 33,
      height = 27,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["order"] = "high"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 53, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 53, 52, 53, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 15,
      name = "complete nodes",
      x = 0,
      y = 0,
      width = 33,
      height = 27,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["graph"] = "true"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 106, 101, 106, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 106, 0, 106, 101, 106, 0, 0, 106, 101, 106, 101, 106, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 101, 106, 0, 0, 0, 106, 0, 106, 101, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 106, 102, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 102, 0, 0, 102, 0, 0, 102, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        101, 0, 0, 0, 0, 102, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 102, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 102, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        91, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        106, 102, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 104, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106,
        101, 102, 0, 0, 0, 102, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 102, 0, 102, 0, 0, 101,
        106, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        101, 0, 0, 0, 0, 102, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 102, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 106, 101, 106, 0, 0, 106, 101, 106, 0, 0, 0, 0, 0, 0, 0, 106, 0, 106, 101, 106, 0, 0, 106, 101, 106, 101, 106, 0, 0
      }
    }
  }
}
