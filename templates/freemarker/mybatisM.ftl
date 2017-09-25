<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >

<mapper namespace="${basePackage}.${table.className}Dao">

	<resultMap id="${table.className}Map" type="${basePackage}.${table.className}">
		<#list table.primaryKeys as key>
			<result property="${key.javaProperty}" jdbcType="${key.jdbcTypeName}" column="${key.columnName}" />
		</#list>
		<#list table.baseColumns as column>
			<result property="${column.javaProperty}" jdbcType="${column.jdbcTypeName}" column="${column.columnName}" />
		</#list>
	</resultMap>

	<sql id="Base_Column_List">
	<#list table.primaryKeys as key> ${key.columnName},</#list><#list table.baseColumns as column> <#if column_has_next>${column.columnName},</#if><#if !(column_has_next)>${column.columnName}</#if></#list>
	</sql>

	<sql id="Base_Colum_Where">
		<where>
		<#list table.primaryKeys as key>
			<if test="${key.columnName} != null">
				and ${key.columnName} = ${"#"}${"{"}${key.javaProperty}${"}"}
			</if>
		</#list>
		<#list table.baseColumns as column>
			<if test="${column.columnName} != null">
                and ${column.columnName} = ${"#"}${"{"}${column.javaProperty}${"}"}
			</if>
		</#list>
		</where>
	</sql>

	<select id="find${table.className}ById" parameterType="${basePackage}.${table.className}" resultMap="${table.className}Map">
		select
		<include refid="Base_Column_List" />
		from ${table.tableName}
		where 
		<#list table.primaryKeys as key>
			${key.columnName} = ${"#"}${"{"}${key.javaProperty}${"}"}
		</#list>
	</select>

	<insert id="insert${table.className}" parameterType="${basePackage}.${table.className}">
		insert into ${table.tableName} 
		<trim prefix="(" suffix=")" suffixOverrides=",">
		<#list table.primaryKeys as key>
			<if test="${key.columnName} != null">
				${key.columnName},
			</if>
		</#list>
		<#list table.baseColumns as column>
			<if test="${column.columnName} != null">
				${column.columnName},
			</if>
		</#list>
		</trim>
		<trim prefix="values (" suffix=")" suffixOverrides=",">
		<#list table.primaryKeys as key>
			<if test="${key.columnName} != null">
				${"#"}${"{"}${key.javaProperty}${"}"},
			</if>
		</#list>
		<#list table.baseColumns as column>
			<if test="${column.columnName} != null">
				${"#"}${"{"}${column.javaProperty}${"}"},
			</if>
		</#list>
		</trim>
	</insert>
	
	<insert id="save${table.className}" parameterType="${basePackage}.${table.className}">
		insert into ${table.tableName} (
		<include refid="Base_Column_List" />
		) values (
	<#list table.primaryKeys as key>
		${"#"}${"{"}${key.javaProperty}${"}"},
	</#list>
	<#list table.baseColumns as column>
		${"#"}${"{"}${column.javaProperty}${"}"},
	</#list>
		)
	</insert>

	<update id="update${table.className}" parameterType="${basePackage}.${table.className}">
		update
		${table.tableName}
		<set>
		<#list table.primaryKeys as key>
			<if test="${key.javaProperty} != null">
				${key.columnName} = ${"#"}${"{"}${key.javaProperty}${"}"},
			</if>
		</#list>
		<#list table.baseColumns as column>
			<if test="${column.javaProperty} != null">
				${column.columnName} = ${"#"}${"{"}${column.javaProperty}${"}"},
			</if>
		</#list>
		</set>
		where 
	<#list table.primaryKeys as key>
		${key.columnName} = ${"#"}${"{"}${key.javaProperty}${"}"}
	</#list>
	</update>
</mapper>

