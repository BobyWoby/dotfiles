vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
-- Telescope
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

-- Rose-Pine
  use({ 'rose-pine/neovim', as = 'rose-pine',

  config = function()
	  vim.cmd('colorscheme rose-pine')
  end
  })


-- Nord
  --use({'shaunsingh/nord.nvim', 
  --as = 'nord-nvim',
  --config = function()
	  --vim.cmd[[colorscheme nord]]
	  --vim.g.nord_contrast = true
	  --end})

use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use( 'nvim-treesitter/playground')

-- Undo Tree
use 'mbbill/undotree'
use 'tpope/vim-fugitive'

-- LSP Zero
use {
	'VonHeikemen/lsp-zero.nvim',
	requires = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	}
}

-- Mason
use { "mason-org/mason.nvim"
}
use { 'mason-org/mason-lspconfig.nvim' }
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
}



-- Comment
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup(
            {
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<C-/>',
                    ---Block-comment toggle keymap
                    block = '<C-?>',
                },
            }
        )
    end
}


-- Vsnip
use { 'hrsh7th/vim-vsnip'}
use { 'hrsh7th/vim-vsnip-integ'}
use { 'hrsh7th/cmp-vsnip'}

-- LSP-Signature
use {
  "ray-x/lsp_signature.nvim",
}

use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
}


use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
use  'theHamsta/nvim-dap-virtual-text'

use({
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
})

end)
