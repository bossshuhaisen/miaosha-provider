package com.shs.Dao;

import com.shs.Model.Sp;
import java.util.List;

public interface SpMapper {
    int deleteByPrimaryKey(String id);

    int insert(Sp record);

    Sp selectByPrimaryKey(String id);

    List<Sp> selectAll();

    int updateByPrimaryKey(Sp record);
    int updateById(String id);
}