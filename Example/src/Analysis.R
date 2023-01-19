library("ProjectTemplate")
load.project()


a<-application.checkpoints %>% summarise(
  across(everything(), ~ sum(is.na(.)))
)

a1<-gpu %>% summarise(
  across(everything(), ~ sum(is.na(.)))
)

a2<-task.x.y %>% summarise(
  across(everything(), ~ sum(is.na(.)))
)


question1 <- filter(application.checkpoints,
                      eventName=="TotalRender")%>%
              count(eventType,sort = T)


bar_GB<- ggplot(data = question1) + 
  geom_bar(
    mapping = aes(x = eventType, y=n,fill = eventType), 
    show.legend = FALSE,
    stat = "identity"
  ) + 
  theme(aspect.ratio = 1)

bar_GB1 <- gpu[1:1000,] %>%
  ggplot(aes(x = powerDrawWatt, y = gpuTempC)) +
  geom_point()


df<-application.checkpoints %>%
  count(taskId, sort = T)

df1<- filter(application.checkpoints,
     taskId=="0052c4f2-9b51-4063-86da-bc09db2f2029"|
       taskId=="00827017-eab4-4964-870d-f529078b3334"|
       taskId=="0100ab5f-47cd-4667-9bec-0dd1f44066b8")%>% 
    left_join(gpu, by = "hostname")
  

bar_GB2<-df1 %>%
  ggplot(aes(x = gpuUtilPerc, fill = taskId)) +
  geom_histogram()


bar_GB3<-df1 %>%
  ggplot(aes(x =gpuMemUtilPerc, color = taskId)) +
  geom_freqpoly()


bar_GB4<-gpu %>%
  ggplot(aes(x = gpuUtilPerc)) +
  geom_freqpoly()

bar_GB5<-gpu %>%
  ggplot(aes(x = gpuMemUtilPerc)) +
  geom_freqpoly()


gpu[1:1000,] %>%
  ggplot(aes(x = gpuSerial, y = gpuMemUtilPerc,)) +
  geom_point()

colnames(gpu)

df2<-task.x.y %>%
  count(level, sort = T)

bar_GB6<- ggplot(data = df2) + 
  geom_bar(
    mapping = aes(x = level, y=n,fill = level), 
    show.legend = FALSE,
    stat = "identity"
  ) + 
  theme(aspect.ratio = 1)

df3<- application.checkpoints[1:3000,]%>% 
  left_join(gpu, by = "hostname")

bar_GB7<- df3 %>%
  ggplot(aes(x = eventName, y =powerDrawWatt))+
  geom_boxplot()



df4<-df3 %>%
  group_by(eventName) %>%
  summarize(across(c(powerDrawWatt,gpuTempC,gpuUtilPerc,gpuMemUtilPerc), mean, na.rm = TRUE))


bar_GB8<-df3 %>%
  ggplot(aes(x = powerDrawWatt)) +
  geom_density() +
  facet_wrap(vars(eventName), scales = "free")

bar_GB9<-df3 %>%
  ggplot(aes(x = gpuUtilPerc)) +
  geom_density(aes(fill = eventType)) +
  facet_wrap(vars(eventName), scales = "free")

bar_GB10<-gpu[1:1000,] %>%
  ggplot(aes(x = gpuSerial, y = powerDrawWatt)) +
  geom_point()

bar_GB11<-gpu[1:1000,] %>%
  ggplot(aes(x = gpuSerial, y = gpuMemUtilPerc)) +
  geom_point()

bar_GB12<-gpu[1:1000,] %>%
  ggplot(aes(x = gpuSerial, y = gpuUtilPerc)) +
  geom_point()



