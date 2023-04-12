local class = require('lib.class')
local vec3 = require('lib.vec3')
local ray = require('lib.ray')
local material = require('lib.material')

---Represents a lambertian (matte) material
---@class lambertian : material
---@overload fun(): lambertian
---@field albedo color
local lambertian = class(material)

---Init the material
---@param albedo color
function lambertian:new(albedo)
	self.albedo = albedo
end

---Scatter and color a ray that hits the material
---@param r_in ray
---@param rec hit_record
---@param attenuation color
---@param scattered ray
---@return boolean
function lambertian:scatter(r_in, rec, attenuation, scattered)
	local scatter_direction = rec.normal + vec3.random_unit_vector()

	if scatter_direction:near_zero() then
		scatter_direction = rec.normal
	end

	scattered:replace_with(ray(rec.p, scatter_direction, r_in.time))
	attenuation:replace_with(self.albedo)
	return true
end

return lambertian
