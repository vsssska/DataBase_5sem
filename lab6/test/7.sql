CREATE OR REPLACE FUNCTION delete_from_child()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM public.monitors
    WHERE monitor_id = OLD.monitor_id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER After_Delete
AFTER DELETE ON public.orders
FOR EACH ROW
EXECUTE FUNCTION delete_from_child();
