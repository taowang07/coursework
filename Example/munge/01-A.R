# Example preprocessing script.
question1 <- filter(application.checkpoints,
                    eventName=="TotalRender")%>%
  count(eventType,sort = T)

df<-application.checkpoints %>%
  count(taskId, sort = T)

df1<- filter(application.checkpoints,
             taskId=="0052c4f2-9b51-4063-86da-bc09db2f2029"|
               taskId=="00827017-eab4-4964-870d-f529078b3334"|
               taskId=="0100ab5f-47cd-4667-9bec-0dd1f44066b8")%>% 
  left_join(gpu, by = "hostname")

df2<-task.x.y %>%
  count(level, sort = T)