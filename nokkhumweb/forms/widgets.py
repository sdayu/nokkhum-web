'''
Created on Jul 20, 2014

@author: boatkrap
'''

from wtforms import widgets
from wtforms.widgets import core

import io


def get_bootstrap(field):
    str_io = io.StringIO()

    if len(field.errors) > 0:
        str_io.write('<div class="form-group has-error">')
    else:
        str_io.write('<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label textfield-demo">')

    if len(field.errors) > 0:
        field.label.text += ": "+field.errors[0]
    str_io.write('%s')
    str_io.write(field.label(class_="mdl-textfield__label"))

    str_io.write('</div>')

    html = str_io.getvalue()
    str_io.close()
    return html


class MdlInput(widgets.TextInput):

    def __init__(self):
        super().__init__()

    def __call__(self, field, **kwargs):
        kwargs['class_'] = "mdl-textfield__input"

        html = get_bootstrap(field) % super().__call__(field, **kwargs)
        return core.HTMLString(html)


class MdlPassword(widgets.PasswordInput):

    def __init__(self):
        super().__init__()

    def __call__(self, field, **kwargs):
        kwargs['class_'] = "mdl-textfield__input"

        html = get_bootstrap(field) % super().__call__(field, **kwargs)
        return core.HTMLString(html)


class MdlCheckbox(widgets.CheckboxInput):
    def __init__(self):
        super().__init__()

    def __call__(self, field, **kwargs):
        kwargs['class_'] = "form-control"

        str_io = io.StringIO()
        str_io.write('<div class="checkbox"><label><input type="checkbox">')
        str_io.write(field.label.text)
        str_io.write('</label></div>')
        html = str_io.getvalue()
        str_io.close()

        return core.HTMLString(html)
    

class MdlRadio(widgets.RadioInput):
    def __init__(self):
        super().__init__()
        
    def __call__(self, field, **kwargs):
        kwargs['class_'] = "form-control"

        str_io = io.StringIO()
        str_io.write('<label>%s</label> '%field.label.text)

        for subfield in field:
            str_io.write('<label class="radio-inline">%s%s</label>' % (subfield, subfield.label.text))

        html = str_io.getvalue()
        str_io.close()

        return core.HTMLString(html)


class MdlSelect(widgets.Select):

    def __init__(self):
        super().__init__()

    def __call__(self, field, **kwargs):
        kwargs['class_'] = "form-control"

        html = get_bootstrap(field) % super().__call__(field, **kwargs)
        return core.HTMLString(html)


class MdlForm:

    def __call__(self, field, **kwargs):
        str_io = io.StringIO()
        str_io.write(field.label())
        str_io.write(':')
        str_io.write('<div class="well well-sm">')

        for subfield in field:
            if subfield.type == 'HiddenField':
                str_io.write(subfield)
            else:
                str_io.write(subfield())

        str_io.write('</div>')
        html = str_io.getvalue()
        str_io.close()
        return core.HTMLString(html)


class MdlList:

    def __call__(self, field, **kwargs):
        kwargs.setdefault('id', field.id)
        str_io = io.StringIO()
        str_io.write(field.label())
        str_io.write(':')
        str_io.write('<div class="well well-sm">')

        for subfield in field:
            str_io.write(subfield(**kwargs))

        str_io.write('</div>')
        html = str_io.getvalue()
        str_io.close()
        return core.HTMLString(html)


