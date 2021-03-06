<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <springProperty scope="context" name="ACTIVE_PROFILE" source="spring.profiles.active"/>
    <property resource="application-${r"$"}{ACTIVE_PROFILE}.properties"/>
    <property name="LOG_HOME" value="${r"$"}{logs.home}"/>
    <springProfile name="default,dev">
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} %boldYellow([%thread]) %highlight(%-5level) %boldGreen(%logger{36}): - %msg%n
                </pattern>
            </encoder>
        </appender>
    </springProfile>
    <appender name="FILE-DEBUG" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>DEBUG</level>
            <OnMismatch>DENY</OnMismatch>
            <OnMatch>ACCEPT</OnMatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${r"$"}{LOG_HOME}/${projectArtifactId}_debug.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>10</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36}: - %msg%n</pattern>
        </encoder>
    </appender>
    <appender name="FILE-INFO" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>INFO</level>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${r"$"}{LOG_HOME}/${projectArtifactId}_info.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>10</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36}: - %msg%n</pattern>
        </encoder>
    </appender>
    <appender name="FILE-ERROR" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>WARN</level>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${r"$"}{LOG_HOME}/${projectArtifactId}_error.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>10</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36}: - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="uk.org.lidalia.sysoutslf4j.context.SysOutOverSLF4J" level="ERROR"/>
    <logger name="${projectPackage}" level="INFO"/>
    <!-- set level 'DEBUG' then print sql log -->
    <logger name="${projectPackage}.dao" level="INFO"/>

    <root level="INFO">
        <springProfile name="default,dev">
            <appender-ref ref="STDOUT"/>
        </springProfile>
        <springProfile name="test,stage,prod">
            <appender-ref ref="FILE-DEBUG"/>
            <appender-ref ref="FILE-INFO"/>
            <appender-ref ref="FILE-ERROR"/>
        </springProfile>
    </root>
</configuration>
