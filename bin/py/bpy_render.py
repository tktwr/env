import bpy
import os
import math
import bpy_util as bu


class Render():
    def __init__(self):
        self.set_engine('BLENDER_EEVEE')
        self.set_size((1024, 1024))
        self.set_tonemap('Filmic')

    def set_engine(self, engine):
        scene = bpy.context.scene
        if engine == 'eevee':
            scene.render.engine = 'BLENDER_EEVEE'
        elif engine == 'cycles':
            scene.render.engine = 'CYCLES'
            scene.cycles.feature_set = 'SUPPORTED'
            scene.cycles.device = 'GPU'

    def set_size(self, size):
        scene = bpy.context.scene
        scene.render.resolution_x = size[0]
        scene.render.resolution_y = size[1]
        scene.render.resolution_percentage = 100

    def set_tonemap(self, tonemap):
        scene = bpy.context.scene
        scene.view_settings.view_transform = tonemap

    def set_exposure(self, exposure):
        scene = bpy.context.scene
        scene.view_settings.exposure = exposure

    def render(self, cam_name, light_names, env_file, env_intensity, rot_deg, out_file):
        scene = bpy.context.scene
        world = bpy.data.worlds["World"]

        scene.camera = scene.objects.get(cam_name)
        bu.show_lights(light_names)

        node = bu.find_node(world.node_tree, 'ShaderNodeTexEnvironment')
        if node != None and env_file != "":
            node.image = bpy.data.images.load(env_file)

        node = bu.find_node(world.node_tree, 'ShaderNodeBackground')
        if node != None:
            node.inputs[1].default_value = env_intensity

        node = bu.find_node(world.node_tree, 'ShaderNodeMapping')
        if node != None:
            node.inputs[2].default_value[2] = rot_deg * math.pi / 180

        bpy.ops.render.render()
        bpy.data.images['Render Result'].save_render(filepath = out_file)


