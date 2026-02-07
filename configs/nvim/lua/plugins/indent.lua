return {
	{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			---@module "ibl"
			---@type ibl.config
			opts = {},
	},
	{
		'nmac427/guess-indent.nvim',
		config = function() require('guess-indent').setup {} end,
	}
}
