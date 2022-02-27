import bpy
import os
import math


def find_obj_by_name(name, data_type=bpy.types.Mesh):
    for o in bpy.data.objects:
        if o.name == name and isinstance(o.data, data_type):
            return o
    return None


def hide_lights():
    for o in bpy.data.objects:
        if o.name.startswith('Light'):
            o.hide_render = True


def show_lights(light_names):
    hide_lights()
    for i in light_names:
        bpy.data.objects[i].hide_render = False


def render(cam_name, light_names, env_file, env_intensity, rot_deg, out_file):
    bpy.context.scene.camera = bpy.context.scene.objects.get(cam_name)
    show_lights(light_names)
    if env_file != "":
        bpy.data.worlds["World"].node_tree.nodes['Environment Texture'].image = bpy.data.images.load(env_file)
    bpy.data.worlds["World"].node_tree.nodes['Background'].inputs[1].default_value = env_intensity
    if rot_deg != 0:
        bpy.data.worlds["World"].node_tree.nodes['Mapping'].inputs[2].default_value[2] = rot_deg * math.pi / 180

    bpy.ops.render.render()
    bpy.data.images['Render Result'].save_render(filepath = out_file)


def init(engine, w, h):
    bpy.context.scene.render.resolution_x = w
    bpy.context.scene.render.resolution_y = h
    bpy.context.scene.render.resolution_percentage = 100

    if engine == 'eevee':
        bpy.context.scene.render.engine = 'BLENDER_EEVEE'
    elif engine == 'cycles':
        bpy.context.scene.render.engine = 'CYCLES'
        bpy.context.scene.cycles.device = 'GPU'

