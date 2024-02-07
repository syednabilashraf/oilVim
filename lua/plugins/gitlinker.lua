local function detect_git_remote()
  local gh_default_repo = vim.fn.system({
    "gh",
    "repo",
    "view",
    "--json=nameWithOwner",
    "--template={{.nameWithOwner}}",
  })

  local remotes = vim.fn.systemlist({ "git", "remote", "-v" })
  for _, remote in ipairs(remotes) do
    local name, url = string.match(remote, "(.+)\t(.+) %((.+)%)")
    if string.find(url, gh_default_repo, 1, true) then
      return name
    end
  end
end

local function get_remote()
  local remote = vim.t.gitlinker_remote_override
  if remote == nil then
    local ok, value = pcall(detect_git_remote)
    remote = ok and value or false
    vim.t.gitlinker_remote_override = remote
  end
  return remote
end

return {
  "ruifm/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local opt = {
      opts = {
        remote = get_remote(),
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = true,
        -- callback for what to do with the url
        action_callback = require("gitlinker.actions").copy_to_clipboard,
        -- print the url after performing the action
        print_url = true,
      },
      callbacks = {
        ["github.com"] = require("gitlinker.hosts").get_github_type_url,
        ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
        ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
        ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
        ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
        ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
        ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
        ["repo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
        ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
        ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
      },
      -- default mapping to call url generation with action_callback
      mappings = "<leader>gy",
    }
    return opt
  end,
}
