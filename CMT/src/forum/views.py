from django.shortcuts import render, Http404, HttpResponse, HttpResponseRedirect
from django.contrib.auth.decorators import login_required

# Create your views here.
from courses.models import Course, Semester
from .models import Discussion
from .forms import DiscussionForm


@login_required
def discussion_list(request, semester_slug, course_slug):
    # try:

    semester = Semester.objects.get(slug=semester_slug)
    # except:
    # 	raise Http404
    # try:
    course = Course.objects.get(slug=course_slug)
    discussions = Discussion.objects.filter(course=course)
    discussion_form = DiscussionForm(request.POST or None)
    parent_discussion = None
    if discussion_form.is_valid():
        parent_id = request.POST.get('parent_id')
        if parent_id is not None:
            try:
                parent_discussion = Discussion.objects.get(id=parent_id)
            except:
                parent_discussion = None

        discussion_content = discussion_form.cleaned_data['discussion']
        new_discussion = Discussion.objects.add_discussion(
            user=request.user,
            path=request.get_full_path(),
            content=discussion_content,
            course=course,
            parent=parent_discussion
        )
        # return HttpResponseRedirect("/forum/")
        return HttpResponseRedirect("/semester/%s/%s/forum/" % (semester_slug, course_slug))

    return render(request, 'forum.html', {
        "course": course,
        "discussions": discussions,
        "discussion_form": discussion_form})


# except:
# 	raise Http404


@login_required
def discussion_thread(request, thread_id, semester_slug, course_slug):
    discussion = Discussion.objects.get(id=thread_id)
    form = DiscussionForm()
    context = {
        "form": form,
        "semester_slug": semester_slug,
        "course_slug": course_slug,
        "discussion": discussion,
    }

    return render(request, "forum/discussion_thread.html", context)

# def discussion_create_view(request, id, semester_slug, course_slug):
# 	if request.method == "POST" and request.user.is_authenticated():
# 		form = DiscussionForm(request.POST)
# 		if form.is_valid():
# 			parent_id = request.POST.get('parent_id')
# 			if parent_id is not None:
# 				try:
# 					parent_discussion = Discussion.objects.get(id=parent_id)
# 				except:
# 					parent_discussion = None

# 			discussion_content = form.cleaned_data['discussion']
# 			course = None

# 			if parent_discussion is not None:
# 				new_discussion = Discussion.objects.add_discussion(
# 					user=request.user, 
# 					path=parent_discussion.get_origin, 
# 					content=discussion_content,
# 					course=parent_discussion.course,
# 					parent=parent_discussion
# 					)
# # 			# else:
# # 			# 	new_discussion = Discussion.objects.add_discussion(
# # 			# 		user=request.user, 
# # 			# 		path=parent_discussion.get_origin, 
# # 			# 		content=discussion_content,
# # 			# 		course=course,
# # 			# 		parent=parent_discussion
# # 			# 		)
# 			return 
# # 	# else:
# # 	# 	raise Http404
