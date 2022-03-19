import bpy


#------------------------------------------------------
# object
#------------------------------------------------------
def find_obj_by_name(name, data_type=bpy.types.Mesh):
    for o in bpy.data.objects:
        if o.name == name and isinstance(o.data, data_type):
            return o
    return None


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


