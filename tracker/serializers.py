from rest_framework import serializers
from .models import Project, Task, Contributor

class ContributorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contributor
        fields = '__all__'

class TaskSerializer(serializers.ModelSerializer):
    contributors = ContributorSerializer(many=True, read_only=True)
    contributor_ids = serializers.PrimaryKeyRelatedField(queryset=Contributor.objects.all(), many=True, write_only=True, required=False)

    class Meta:
        model = Task
        fields = ['id','project','title','description','due_date','is_completed','is_overdue','contributors','contributor_ids']

    def create(self, validated_data):
        contributor_ids = validated_data.pop('contributor_ids', [])
        task = Task.objects.create(**validated_data)
        task.contributors.set(contributor_ids)
        return task

    def update(self, instance, validated_data):
        contributor_ids = validated_data.pop('contributor_ids', None)
        for attr, val in validated_data.items():
            setattr(instance, attr, val)
        instance.save()
        if contributor_ids is not None:
            instance.contributors.set(contributor_ids)
        return instance

class ProjectSerializer(serializers.ModelSerializer):
    tasks = TaskSerializer(many=True, read_only=True)

    class Meta:
        model = Project
        fields = '__all__'
