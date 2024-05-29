#include <string.h>

#include "Context.h"

#include "SysTask.h"
#include "SysCall.h"
#include "SysSched.h"


unsigned gNestLayer = 0;


void saveContext(const Context* context)
{
	if(!gCurrentTask)
		return;

	memcpy(&gCurrentTask->context, context, sizeof(Context));
}

void recoverContext(Context* context)
{
	int result;

	if(!gSchedtoTask)
		return;

	memcpy(context, &gSchedtoTask->context, sizeof(Context));

	gCurrentTask = gSchedtoTask;
	gCurrentTask->tickCount = 0;
	gCurrentTask->state = TaskStateRunning;

	if(gCurrentTask->sysCallBlock)
	{
		result = leaveSysCall(context->a0, context->a1, context->a2, context->a3, context->a4);
		context->a0 = result;

		gCurrentTask->sysCallBlock = false;
	}
}

int prepareTask(TaskEntry entry, void* arg, void* stack, size_t size, Context* context)
{
	if(size < sizeof(Context))
		return -1;

	stack += size;

	memset(context, 0, sizeof(Context));
	
	context->sp = (uintptr_t)stack;
	context->pc = (uintptr_t)entry;
	context->a0 = (uintptr_t)arg;
	context->ra = (uintptr_t)finishTask;
	
	return 0;
}

void finishTask(void)
{
	sysCall(SysCallTaskExit, 0, 0, 0, 0);
	// Never came back
}
