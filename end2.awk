BEGIN {
     count = 0;
    delay=0;
}
{
   action = $1;
   time = $2;
   type = $5;
   pktsize = $6;
   packet_id = $11;

   if(type =="tcp" && action=="+" && $3== a && $4==b)
   {startime[$11]=time;list[count]=$11;count++;stoptime[$11]=0;}
   if(type =="tcp" && action=="r" && $3== a && $4==b)
   {stoptime[$11]=time;}
}
END { if(count!=0)
             for(k=0;k<count;k++)
              {
                    if(stoptime[list[k]]!=0 )
                     {  delay=stoptime[list[k]]-startime[list[k]]+delay;





}

               }
               if(count!=0)
               print("Average delay between",a,"and",b," nodes:",delay/count);
}
