kubectl delete -n trgs service/kafdrop-loadbalancer    2>/dev/null
kubectl delete -n trgs service/kafka-loadbalancer      2>/dev/null
kubectl delete -n trgs service/trgs-zookeeper-service  2>/dev/null
kubectl delete -n trgs service/trgs-kafka-int          2>/dev/null
kubectl delete -n trgs service/trgs-kafka-ext          2>/dev/null
kubectl delete -n trgs service/trgs-kafka              2>/dev/null
kubectl delete -n trgs service/trgs-kafka-lb           2>/dev/null
kubectl delete -n trgs pod/trgs-kafdrop                2>/dev/null
kubectl delete -n trgs pod/trgs-kafka                  2>/dev/null
kubectl delete -n trgs statefulset.apps/trgs-zookeeper 2>/dev/null
kubectl get all -n trgs
[[ "$1" == "delete" ]] && exit
sleep 8
kubectl get all -n trgs
sleep 1
kubectl create -f trgs-namespace.yaml 2>/dev/null
kubectl create -f zookeeper-statefulset.yaml
kubectl create -f zookeeper-service.yaml
sleep 5
kubectl create -f kafka-pod.yaml
kubectl create -f kafka-service.yaml
#kubectl create -f kafka-loadbalancer.yaml
#kubectl create -f kafka-service-ext.yaml
sleep 5
kubectl create -f kafdrop-pod.yaml
kubectl create -f kafdrop-service.yaml
watch -d -n 1 "kubectl get all -n trgs"

