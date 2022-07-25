import bpy
import math


#------------------------------------------------------
# material params
#------------------------------------------------------
MAT_PARAM_30 = {
    "Base Color": 0,
    "Subsurface": 1,
    "Subsurface Radius": 2,
    "Subsurface Color": 3,
    "Subsurface IOR": 4,
    "Subsurface Anisotropy": 5,
    "Metallic": 6,
    "Specular": 7,
    "Specular Tint": 8,
    "Roughness": 9,
    "Anisotropic": 10,
    "Anisotropic Rotation": 11,
    "Sheen": 12,
    "Sheen Tint": 13,
    "Clearcoat": 14,
    "Clearcoat Roughness": 15,
    "IOR": 16,
    "Transmission": 17,
    "Transmission Roughness": 18,
    "Emission": 19,
    "Emission Strength": 20,
    "Alpha": 21,
    "Normal": 22,
    "Clearcoat Normal": 23,
    "Tangent": 24,
}


#------------------------------------------------------
# math
#------------------------------------------------------
def radians3(deg3):
    return [math.radians(i) for i in deg3]


#------------------------------------------------------
# node_tree
#------------------------------------------------------
def print_nodes(node_tree):
    if node_tree != None:
        for i in node_tree.nodes:
            print(i)


def find_node(node_tree, idname):
    if node_tree != None:
        for i in node_tree.nodes:
            if i.bl_idname == idname:
                return i
    return None


def find_principled_bsdf_node(mat):
    if mat.node_tree != None:
        for i in mat.node_tree.nodes:
            if i.bl_idname == 'ShaderNodeBsdfPrincipled':
                return i
    return None


#------------------------------------------------------
# link
#------------------------------------------------------
def get_to_socket(mat, socket_name):
    if mat.node_tree != None:
        for i in mat.node_tree.links:
            if i.to_node.bl_idname == 'ShaderNodeBsdfPrincipled' and \
               i.to_socket.identifier == socket_name:
                return i.to_socket
    return None


def get_from_socket(mat, socket_name):
    if mat.node_tree != None:
        for i in mat.node_tree.links:
            if i.to_node.bl_idname == 'ShaderNodeBsdfPrincipled' and \
               i.to_socket.identifier == socket_name:
                return i.from_socket
    return None


def make_link(mat, to_socket, from_socket):
    return mat.node_tree.links.new(to_socket, from_socket)


#------------------------------------------------------
# gltf
#------------------------------------------------------
def add_gltf_shader_node(node_tree):
    GLTF_GROUP_NAME = 'glTF Settings'

    if GLTF_GROUP_NAME in bpy.data.node_groups:
        gltf_grp = bpy.data.node_groups[GLTF_GROUP_NAME]
    else:
        gltf_grp = bpy.data.node_groups.new(GLTF_GROUP_NAME, 'ShaderNodeTree')
        gltf_grp.inputs.new('NodeSocketFloat', 'Occlusion')
        gltf_grp.nodes.new('NodeGroupOutput')
        gltf_grp.nodes.new('NodeGroupInput')

    gltf_ao = node_tree.nodes.new('ShaderNodeGroup')
    gltf_ao.node_tree = gltf_grp
    return gltf_ao


#------------------------------------------------------
# env
#------------------------------------------------------
def add_env_shader_node(env_file):
    world = bpy.data.worlds["World"]
    node_tree = world.node_tree
    nodes = node_tree.nodes

    env = bpy.data.images.load(env_file)

    node_bg = find_node(node_tree, 'ShaderNodeBackground')
    node_texenv = nodes.new('ShaderNodeTexEnvironment')
    node_texenv.image = env
    node_mapping = nodes.new('ShaderNodeMapping')
    node_texcoord = nodes.new('ShaderNodeTexCoord')

    node_texenv.location = (-300, 0)
    node_mapping.location = (-300 * 2, 0)
    node_texcoord.location = (-300 * 3, 0)

    node_tree.links.new(node_bg.inputs[0], node_texenv.outputs[0])
    node_tree.links.new(node_texenv.inputs[0], node_mapping.outputs[0])
    node_tree.links.new(node_mapping.inputs[0], node_texcoord.outputs[0])


#======================================================
# Scene
#======================================================
def clear_all():
    for i in bpy.data.cameras:
        bpy.data.cameras.remove(i)
    for i in bpy.data.lights:
        bpy.data.lights.remove(i)
    for i in bpy.data.meshes:
        bpy.data.meshes.remove(i)
    for i in bpy.data.materials:
        bpy.data.materials.remove(i)
    for i in bpy.data.objects:
        bpy.data.objects.remove(i)
    for i in bpy.data.collections:
        bpy.data.collections.remove(i)


def set_mat_custom_props():
    for mat in bpy.data.materials:
        print(f'mat.name = {mat.name}')
        bsdf = find_principled_bsdf_node(mat)
        if bsdf != None:
            print(f'bsdf.name = {bsdf.name}')
            mat['u_subsurface'] = get_mat_param(mat, 'Subsurface')
            mat['u_subsurface_radius'] = get_mat_param(mat, 'Subsurface Radius')
            mat['u_specular'] = get_mat_param(mat, 'Specular')
            mat['u_specular_tint'] = get_mat_param(mat, 'Specular Tint')
            mat['u_sheen'] = get_mat_param(mat, 'Sheen')
            mat['u_sheen_tint'] = get_mat_param(mat, 'Sheen Tint')
            mat['u_clearcoat'] = get_mat_param(mat, 'Clearcoat')
            mat['u_clearcoat_roughness'] = get_mat_param(mat, 'Clearcoat Roughness')
            mat['u_ior'] = get_mat_param(mat, 'IOR')
            mat['u_transmission'] = get_mat_param(mat, 'Transmission')
            mat['u_transmission_roughness'] = get_mat_param(mat, 'Transmission Roughness')

            normal_scale = get_normal_map_strength(mat)
            mat['u_normal_scale'] = (normal_scale, normal_scale, 1.0)


#------------------------------------------------------
# add
#------------------------------------------------------
def add_collection_to_scene(coll):
    bpy.context.scene.collection.children.link(coll)


def add_object_to_scene(obj):
    bpy.context.scene.collection.objects.link(obj)


def link_object_to_collection(obj, coll):
    coll.objects.link(obj)
    bpy.context.scene.collection.objects.unlink(obj)


#------------------------------------------------------
# create
#------------------------------------------------------
def create_collection(name):
    return bpy.data.collections.new(name)


def create_camera(name, loc, rot_deg):
    data = bpy.data.cameras.new(name=name)
    obj = bpy.data.objects.new(name, data)
    obj.location = loc
    obj.rotation_euler = radians3(rot_deg)
    return obj


def create_light(name, loc, power):
    data = bpy.data.lights.new(name=name, type='POINT')
    data.energy = power
    obj = bpy.data.objects.new(name=name, object_data=data)
    obj.location = loc
    return obj


def create_plane(name, sz, loc):
    bpy.ops.mesh.primitive_plane_add(size=1.0, location=loc)
    bpy.context.object.rotation_euler[0] = math.radians(90)
    obj = bpy.context.view_layer.objects.active
    obj.name = name
    obj.data.name = name
    obj.scale = (sz[0], sz[1], 1.0)
    return obj


def create_sphere(name, radius, loc):
    bpy.ops.mesh.primitive_uv_sphere_add(radius=radius, location=loc, scale=(1, 1, 1))
    bpy.ops.object.shade_smooth()
    obj = bpy.context.view_layer.objects.active
    obj.name = name
    obj.data.name = name
    return obj


def create_material(name):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    return mat


def rename_all(src, dst):
    for obj in bpy.data.objects:
        if src in obj.name:
            obj.name = obj.name.replace(src, dst)
        if src in obj.data.name:
            obj.data.name = obj.data.name.replace(src, dst)
    for mat in bpy.data.materials:
        if src in mat.name:
            mat.name = mat.name.replace(src, dst)


#------------------------------------------------------
# object
#------------------------------------------------------
def find_obj_by_name(name, data_type=bpy.types.Mesh):
    for o in bpy.data.objects:
        if o.name == name and isinstance(o.data, data_type):
            return o
    return None


#------------------------------------------------------
# light
#------------------------------------------------------
def hide_lights():
    for o in bpy.data.objects:
        if o.name.startswith('Light'):
            o.hide_render = True


def show_lights(light_names):
    hide_lights()
    for i in light_names:
        bpy.data.objects[i].hide_render = False


#------------------------------------------------------
# material
#------------------------------------------------------
def get_normal_map_strength(mat):
    if mat.node_tree != None:
        for i in mat.node_tree.links:
            if i.to_node.bl_idname == 'ShaderNodeBsdfPrincipled' and \
               i.to_socket.identifier == 'Normal' and \
               i.from_node.bl_idname == 'ShaderNodeNormalMap':
                normal_map_node = i.from_node
                return normal_map_node.inputs[0].default_value
    return 1.0


def set_obj_material(obj, mat):
    obj_matslots = obj.material_slots
    if len(obj_matslots) == 0:
        obj.data.materials.append(mat)
    else:
        obj_matslots[obj.active_material_index].material = mat


def set_mat_param(mat, mat_param_name, val):
    bsdf = find_principled_bsdf_node(mat)
    mat_param_id = MAT_PARAM_30[mat_param_name]
    bsdf.inputs[mat_param_id].default_value = val


def set_mat_param_tex(mat, mat_param_name, tex):
    bsdf = find_principled_bsdf_node(mat)
    mat_param_id = MAT_PARAM_30[mat_param_name]

    nodes = mat.node_tree.nodes
    node = nodes.new('ShaderNodeTexImage')
    node.image = tex
    node.location = (-400, 0)

    mat.node_tree.links.new(bsdf.inputs[mat_param_id], node.outputs[0])


def get_mat_param(mat, mat_param_name):
    bsdf = find_principled_bsdf_node(mat)
    mat_param_id = MAT_PARAM_30[mat_param_name]
    return bsdf.inputs[mat_param_id].default_value


def set_mat_param_all(mat_param_name, val):
    for mat in bpy.data.materials:
        bsdf = find_principled_bsdf_node(mat)
        bsdf.inputs[mat_param_name].default_value = val


