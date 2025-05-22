using UnityEngine;
using Vuforia;

public class ARController : MonoBehaviour, ITrackableEventHandler
{
    private TrackableBehaviour mTrackableBehaviour;

    void Start()
    {
        mTrackableBehaviour = GetComponent<TrackableBehaviour>();
        if (mTrackableBehaviour)
        {
            mTrackableBehaviour.RegisterTrackableEventHandler(this);
        }

        var tracker = TrackerManager.Instance.GetTracker<ObjectTracker>();
        var dataset = tracker.CreateDataSet();
        dataset.Load("vuforia_database.xml", VuforiaUnity.StorageType.STORAGE_APPRESOURCE);
        tracker.ActivateDataSet(dataset);
    }

    public void OnTrackableStateChanged(TrackableBehaviour.Status previousStatus, TrackableBehaviour.Status newStatus)
    {
        if (newStatus == TrackableBehaviour.Status.DETECTED || newStatus == TrackableBehaviour.Status.TRACKED)
        {
            // Load 3D model and narration
            Debug.Log("Exhibit detected, loading AR content");
            var model = GetComponentInChildren<Renderer>();
            if (model) model.enabled = true;

            // Example: Play audio narration
            var audioSource = GetComponent<AudioSource>();
            if (audioSource) audioSource.Play();
        }
        else
        {
            // Hide 3D model
            var model = GetComponentInChildren<Renderer>();
            if (model) model.enabled = false;
        }
    }

    // Called from Flutter to load specific exhibit
    public void LoadExhibit(string exhibitId)
    {
        Debug.Log($"Loading exhibit: {exhibitId}");
        // Logic to load specific 3D model and narration based on exhibitId
    }
}