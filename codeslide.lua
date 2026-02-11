local base_url = 'https://jncraton.github.io/codeslide/'

function Meta(m)
  if m.codeslide_url then
    base_url = pandoc.utils.stringify(m.codeslide_url)
    if not base_url:match('/$') then
      base_url = base_url .. '/'
    end
  end
end

local function urlencode(str)
  if str then
    str = str:gsub('([^%w%.%- ])', function(c)
      return string.format('%%%02X', c:byte())
    end)
    str = str:gsub(' ', '%%20')
  end
  return str
end

function CodeBlock(el)
  if el.classes:includes('python') then
    local code = el.text
    local target = el.attributes['target'] or ''
    local encoded = 'c=' .. urlencode(code)
    if target ~= '' then
      encoded = encoded .. '&t=' .. urlencode(target)
    end
    local url = base_url .. '#' .. encoded
    return pandoc.RawBlock(
      'html',
      '<iframe src="' .. url .. '" style="width: 100%; height: 400px; border: none;"></iframe>'
    )
  end
end
