package ${basePackage}.dao;

import ${basePackage}.entity.${table.className};

public interface ${table.className}Dao {

    public ${table.className} find${table.className}ById(String id);

    public int insert${table.className}(${table.className} obj);

    public int save${table.className}(${table.className} obj);

    public int update${table.className}(${table.className} obj);
}
