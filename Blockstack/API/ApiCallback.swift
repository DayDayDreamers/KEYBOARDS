
protocol ApiCallback
{
    func resultReceived(data : Any!)
    func failWithError(error : Error!)
}