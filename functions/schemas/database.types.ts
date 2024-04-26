export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      available_sectors: {
        Row: {
          company_id: number
          id: number
          sector_id: number
        }
        Insert: {
          company_id: number
          id?: number
          sector_id: number
        }
        Update: {
          company_id?: number
          id?: number
          sector_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_available_sectors_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_available_sectors_sector_id_fkey"
            columns: ["sector_id"]
            isOneToOne: false
            referencedRelation: "sectors"
            referencedColumns: ["id"]
          },
        ]
      }
      board_statuses: {
        Row: {
          battery_level: number
          board_id: number
          created_at: string
          id: number
        }
        Insert: {
          battery_level: number
          board_id: number
          created_at?: string
          id?: number
        }
        Update: {
          battery_level?: number
          board_id?: number
          created_at?: string
          id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_board_statuses_board_id_fkey"
            columns: ["board_id"]
            isOneToOne: false
            referencedRelation: "boards"
            referencedColumns: ["id"]
          },
        ]
      }
      boards: {
        Row: {
          collector_id: number
          company_id: number
          created_at: string
          id: number
          model: string
          mqtt_msg_name: string
          name: string
          serial_number: string
          updated_at: string
        }
        Insert: {
          collector_id: number
          company_id: number
          created_at?: string
          id?: number
          model: string
          mqtt_msg_name: string
          name: string
          serial_number: string
          updated_at: string
        }
        Update: {
          collector_id?: number
          company_id?: number
          created_at?: string
          id?: number
          model?: string
          mqtt_msg_name?: string
          name?: string
          serial_number?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "public_boards_collector_id_fkey"
            columns: ["collector_id"]
            isOneToOne: false
            referencedRelation: "collectors"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_boards_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
        ]
      }
      collector_pressures: {
        Row: {
          collector_id: number
          created_at: string
          filter_in_pressure: number
          filter_out_pressure: number
          id: number
          pressure_difference: number
        }
        Insert: {
          collector_id: number
          created_at?: string
          filter_in_pressure: number
          filter_out_pressure: number
          id?: number
          pressure_difference?: number
        }
        Update: {
          collector_id?: number
          created_at?: string
          filter_in_pressure?: number
          filter_out_pressure?: number
          id?: number
          pressure_difference?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_collector_pressure_collector_id_fkey"
            columns: ["collector_id"]
            isOneToOne: false
            referencedRelation: "collectors"
            referencedColumns: ["id"]
          },
        ]
      }
      collector_sectors: {
        Row: {
          collector_id: number
          created_at: string
          id: number
          sector_id: number
        }
        Insert: {
          collector_id: number
          created_at?: string
          id?: number
          sector_id: number
        }
        Update: {
          collector_id?: number
          created_at?: string
          id?: number
          sector_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_collector_sectors_collector_id_fkey"
            columns: ["collector_id"]
            isOneToOne: false
            referencedRelation: "collectors"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_collector_sectors_sector_id_fkey"
            columns: ["sector_id"]
            isOneToOne: true
            referencedRelation: "sectors"
            referencedColumns: ["id"]
          },
        ]
      }
      collectors: {
        Row: {
          company_id: number
          connected_filter_name: string | null
          created_at: string
          id: number
          mqtt_msg_name: string
          name: string
          updated_at: string
        }
        Insert: {
          company_id: number
          connected_filter_name?: string | null
          created_at?: string
          id?: number
          mqtt_msg_name: string
          name: string
          updated_at: string
        }
        Update: {
          company_id?: number
          connected_filter_name?: string | null
          created_at?: string
          id?: number
          mqtt_msg_name?: string
          name?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "public_collectors_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
        ]
      }
      companies: {
        Row: {
          cf: string | null
          created_at: string
          email: string
          id: number
          image_url: string | null
          name: string
          phone_number: string
          piva: string | null
          registered_office_address: string
          updated_at: string
        }
        Insert: {
          cf?: string | null
          created_at?: string
          email: string
          id?: number
          image_url?: string | null
          name: string
          phone_number: string
          piva?: string | null
          registered_office_address: string
          updated_at: string
        }
        Update: {
          cf?: string | null
          created_at?: string
          email?: string
          id?: number
          image_url?: string | null
          name?: string
          phone_number?: string
          piva?: string | null
          registered_office_address?: string
          updated_at?: string
        }
        Relationships: []
      }
      company_users: {
        Row: {
          company_id: number
          created_at: string
          email: string
          full_name: string
          id: number
          role: Database["public"]["Enums"]["role"]
          updated_at: string
        }
        Insert: {
          company_id: number
          created_at?: string
          email: string
          full_name: string
          id?: number
          role: Database["public"]["Enums"]["role"]
          updated_at: string
        }
        Update: {
          company_id?: number
          created_at?: string
          email?: string
          full_name?: string
          id?: number
          role?: Database["public"]["Enums"]["role"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "public_companies_user_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
        ]
      }
      pump_flows: {
        Row: {
          created_at: string
          flow: number
          id: number
          pump_id: number
        }
        Insert: {
          created_at?: string
          flow: number
          id?: number
          pump_id: number
        }
        Update: {
          created_at?: string
          flow?: number
          id?: number
          pump_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_pump_flows_pump_id_fkey"
            columns: ["pump_id"]
            isOneToOne: false
            referencedRelation: "pumps"
            referencedColumns: ["id"]
          },
        ]
      }
      pump_pressures: {
        Row: {
          created_at: string
          filter_in_pressure: number
          filter_out_pressure: number
          id: number
          pressure_difference: number
          pump_id: number
        }
        Insert: {
          created_at?: string
          filter_in_pressure?: number
          filter_out_pressure?: number
          id?: number
          pressure_difference?: number
          pump_id: number
        }
        Update: {
          created_at?: string
          filter_in_pressure?: number
          filter_out_pressure?: number
          id?: number
          pressure_difference?: number
          pump_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_pump_pressures_pump_id_fkey"
            columns: ["pump_id"]
            isOneToOne: false
            referencedRelation: "pumps"
            referencedColumns: ["id"]
          },
        ]
      }
      pump_statuses: {
        Row: {
          created_at: string
          id: number
          pump_id: number
          status: string
          status_boolean: boolean
        }
        Insert: {
          created_at?: string
          id?: number
          pump_id: number
          status: string
          status_boolean?: boolean
        }
        Update: {
          created_at?: string
          id?: number
          pump_id?: number
          status?: string
          status_boolean?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "public_pump_statuses_pump_id_fkey"
            columns: ["pump_id"]
            isOneToOne: false
            referencedRelation: "pumps"
            referencedColumns: ["id"]
          },
        ]
      }
      pumps: {
        Row: {
          capacity_in_volume: number
          company_id: number
          consume_rate_in_kw: number
          created_at: string
          has_filter: boolean
          id: number
          mqtt_msg_name: string
          name: string
          turn_off_command: string
          turn_on_command: string
          updated_at: string
        }
        Insert: {
          capacity_in_volume: number
          company_id: number
          consume_rate_in_kw: number
          created_at?: string
          has_filter?: boolean
          id?: number
          mqtt_msg_name: string
          name: string
          turn_off_command: string
          turn_on_command: string
          updated_at: string
        }
        Update: {
          capacity_in_volume?: number
          company_id?: number
          consume_rate_in_kw?: number
          created_at?: string
          has_filter?: boolean
          id?: number
          mqtt_msg_name?: string
          name?: string
          turn_off_command?: string
          turn_on_command?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "public_pumps_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
        ]
      }
      sector_pressures: {
        Row: {
          created_at: string
          id: number
          pressure: number
          sector_id: number
        }
        Insert: {
          created_at?: string
          id?: number
          pressure: number
          sector_id: number
        }
        Update: {
          created_at?: string
          id?: number
          pressure?: number
          sector_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_sector_pressures_sector_id_fkey"
            columns: ["sector_id"]
            isOneToOne: false
            referencedRelation: "sectors"
            referencedColumns: ["id"]
          },
        ]
      }
      sector_pumps: {
        Row: {
          created_at: string
          id: number
          pump_id: number
          sector_id: number
        }
        Insert: {
          created_at?: string
          id?: number
          pump_id: number
          sector_id: number
        }
        Update: {
          created_at?: string
          id?: number
          pump_id?: number
          sector_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_sector_pumps_pump_id_fkey"
            columns: ["pump_id"]
            isOneToOne: true
            referencedRelation: "pumps"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_sector_pumps_sector_id_fkey"
            columns: ["sector_id"]
            isOneToOne: false
            referencedRelation: "sectors"
            referencedColumns: ["id"]
          },
        ]
      }
      sector_statuses: {
        Row: {
          created_at: string
          id: number
          sector_id: number
          status: string
          status_boolean: boolean
        }
        Insert: {
          created_at?: string
          id?: number
          sector_id: number
          status: string
          status_boolean?: boolean
        }
        Update: {
          created_at?: string
          id?: number
          sector_id?: number
          status?: string
          status_boolean?: boolean
        }
        Relationships: [
          {
            foreignKeyName: "public_sector_statuses_sector_id_fkey"
            columns: ["sector_id"]
            isOneToOne: false
            referencedRelation: "sectors"
            referencedColumns: ["id"]
          },
        ]
      }
      sectors: {
        Row: {
          area: number
          company_id: number
          created_at: string
          has_filter: boolean
          id: number
          irrigation_source: Database["public"]["Enums"]["irrigation_source"]
          irrigation_system_type: Database["public"]["Enums"]["irrigation_system"]
          mqtt_msg_name: string
          name: string
          notes: string | null
          num_of_plants: number
          specie_id: number
          total_consumption: number | null
          turn_off_command: string
          turn_on_command: string
          updated_at: string
          variety_id: number
          water_consumption_per_hour: number
        }
        Insert: {
          area: number
          company_id: number
          created_at?: string
          has_filter?: boolean
          id?: number
          irrigation_source: Database["public"]["Enums"]["irrigation_source"]
          irrigation_system_type: Database["public"]["Enums"]["irrigation_system"]
          mqtt_msg_name: string
          name: string
          notes?: string | null
          num_of_plants: number
          specie_id: number
          total_consumption?: number | null
          turn_off_command: string
          turn_on_command: string
          updated_at: string
          variety_id: number
          water_consumption_per_hour: number
        }
        Update: {
          area?: number
          company_id?: number
          created_at?: string
          has_filter?: boolean
          id?: number
          irrigation_source?: Database["public"]["Enums"]["irrigation_source"]
          irrigation_system_type?: Database["public"]["Enums"]["irrigation_system"]
          mqtt_msg_name?: string
          name?: string
          notes?: string | null
          num_of_plants?: number
          specie_id?: number
          total_consumption?: number | null
          turn_off_command?: string
          turn_on_command?: string
          updated_at?: string
          variety_id?: number
          water_consumption_per_hour?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_sectors_company_id_fkey"
            columns: ["company_id"]
            isOneToOne: false
            referencedRelation: "companies"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_sectors_specie_id_fkey"
            columns: ["specie_id"]
            isOneToOne: false
            referencedRelation: "species"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "public_sectors_variety_id_fkey"
            columns: ["variety_id"]
            isOneToOne: false
            referencedRelation: "varieties"
            referencedColumns: ["id"]
          },
        ]
      }
      species: {
        Row: {
          created_at: string
          id: number
          name: string
        }
        Insert: {
          created_at?: string
          id?: number
          name: string
        }
        Update: {
          created_at?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      superusers: {
        Row: {
          created_at: string
          email: string
          id: number
        }
        Insert: {
          created_at?: string
          email: string
          id?: number
        }
        Update: {
          created_at?: string
          email?: string
          id?: number
        }
        Relationships: []
      }
      terminal_pressures: {
        Row: {
          collector_id: number
          created_at: string
          id: number
          pressure: number
        }
        Insert: {
          collector_id: number
          created_at?: string
          id?: number
          pressure: number
        }
        Update: {
          collector_id?: number
          created_at?: string
          id?: number
          pressure?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_terminal_pressure_collector_id_fkey"
            columns: ["collector_id"]
            isOneToOne: false
            referencedRelation: "collectors"
            referencedColumns: ["id"]
          },
        ]
      }
      varieties: {
        Row: {
          created_at: string
          id: number
          name: string
        }
        Insert: {
          created_at?: string
          id?: number
          name: string
        }
        Update: {
          created_at?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      check_if_user_is: {
        Args: {
          user_email: string
          current_company_id: number
          this_role: string
        }
        Returns: boolean
      }
      check_if_user_is_privileged: {
        Args: {
          user_email: string
          current_company_id: number
        }
        Returns: boolean
      }
      check_if_user_is_superuser: {
        Args: {
          user_email: string
        }
        Returns: boolean
      }
      get_board_company_id: {
        Args: {
          board_id_input: number
        }
        Returns: number
      }
      get_collector_company_id: {
        Args: {
          collector_id_input: number
        }
        Returns: number
      }
      get_collectors_not_connected_to_a_board: {
        Args: {
          company_id_input: number
          id_already_connected?: number
        }
        Returns: {
          company_id: number
          connected_filter_name: string | null
          created_at: string
          id: number
          mqtt_msg_name: string
          name: string
          updated_at: string
        }[]
      }
      get_companies_ids_for_user: {
        Args: {
          user_email: string
        }
        Returns: number[]
      }
      get_pump_company_id: {
        Args: {
          pump_id_input: number
        }
        Returns: number
      }
      get_pumps_not_connected_to_sector: {
        Args: {
          company_id_input: number
          id_already_connected?: number
        }
        Returns: {
          capacity_in_volume: number
          company_id: number
          consume_rate_in_kw: number
          created_at: string
          has_filter: boolean
          id: number
          mqtt_msg_name: string
          name: string
          turn_off_command: string
          turn_on_command: string
          updated_at: string
        }[]
      }
      get_sector_company_id: {
        Args: {
          sector_id_input: number
        }
        Returns: number
      }
      get_user_email: {
        Args: {
          user_id: string
        }
        Returns: string
      }
    }
    Enums: {
      irrigation_source:
        | "well"
        | "cistern"
        | "river"
        | "lake"
        | "canal"
        | "invaso"
        | "consortium"
        | "other"
      irrigation_system:
        | "drip"
        | "pivot"
        | "rotolo"
        | "sprinkler"
        | "subirrigazione"
        | "other"
      role: "superuser" | "owner" | "admin" | "user"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          allowed_mime_types: string[] | null
          avif_autodetection: boolean | null
          created_at: string | null
          file_size_limit: number | null
          id: string
          name: string
          owner: string | null
          owner_id: string | null
          public: boolean | null
          updated_at: string | null
        }
        Insert: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id: string
          name: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Update: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id?: string
          name?: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Relationships: []
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          owner_id: string | null
          path_tokens: string[] | null
          updated_at: string | null
          version: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads: {
        Row: {
          bucket_id: string
          created_at: string
          id: string
          in_progress_size: number
          key: string
          owner_id: string | null
          upload_signature: string
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          id: string
          in_progress_size?: number
          key: string
          owner_id?: string | null
          upload_signature: string
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          id?: string
          in_progress_size?: number
          key?: string
          owner_id?: string | null
          upload_signature?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_bucket_id_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads_parts: {
        Row: {
          bucket_id: string
          created_at: string
          etag: string
          id: string
          key: string
          owner_id: string | null
          part_number: number
          size: number
          upload_id: string
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          etag: string
          id?: string
          key: string
          owner_id?: string | null
          part_number: number
          size?: number
          upload_id: string
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          etag?: string
          id?: string
          key?: string
          owner_id?: string | null
          part_number?: number
          size?: number
          upload_id?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_parts_bucket_id_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "s3_multipart_uploads_parts_upload_id_fkey"
            columns: ["upload_id"]
            isOneToOne: false
            referencedRelation: "s3_multipart_uploads"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_insert_object: {
        Args: {
          bucketid: string
          name: string
          owner: string
          metadata: Json
        }
        Returns: undefined
      }
      extension: {
        Args: {
          name: string
        }
        Returns: string
      }
      filename: {
        Args: {
          name: string
        }
        Returns: string
      }
      foldername: {
        Args: {
          name: string
        }
        Returns: string[]
      }
      get_size_by_bucket: {
        Args: Record<PropertyKey, never>
        Returns: {
          size: number
          bucket_id: string
        }[]
      }
      list_multipart_uploads_with_delimiter: {
        Args: {
          bucket_id: string
          prefix_param: string
          delimiter_param: string
          max_keys?: number
          next_key_token?: string
          next_upload_token?: string
        }
        Returns: {
          key: string
          id: string
          created_at: string
        }[]
      }
      list_objects_with_delimiter: {
        Args: {
          bucket_id: string
          prefix_param: string
          delimiter_param: string
          max_keys?: number
          start_after?: string
          next_token?: string
        }
        Returns: {
          name: string
          id: string
          metadata: Json
          updated_at: string
        }[]
      }
      search: {
        Args: {
          prefix: string
          bucketname: string
          limits?: number
          levels?: number
          offsets?: number
          search?: string
          sortcolumn?: string
          sortorder?: string
        }
        Returns: {
          name: string
          id: string
          updated_at: string
          created_at: string
          last_accessed_at: string
          metadata: Json
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

