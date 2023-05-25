/*
 * Widget Service
 *
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 * Generated by: https://openapi-generator.tech
 */

using System;
using System.Linq;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Text.Json;

namespace WebApi.Models
{ 
    /// <summary>
    /// 
    /// </summary>
    [DataContract]
    public partial class WingDingCreate : IEquatable<WingDingCreate>
    {
        private JsonSerializerOptions _jsonSerializerOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = true
        };

        /// <summary>
        /// Gets or Sets Height
        /// </summary>
        [Required]
        [DataMember(Name="height", EmitDefaultValue=false)]
        public float Height { get; set; }

        /// <summary>
        /// Gets or Sets Width
        /// </summary>
        [Required]
        [DataMember(Name="width", EmitDefaultValue=false)]
        public float Width { get; set; }

        /// <summary>
        /// Gets or Sets Color
        /// </summary>
        [DataMember(Name="color", EmitDefaultValue=false)]
        public APILibraryColor Color { get; set; }

        /// <summary>
        /// Gets or Sets Manufacturer
        /// </summary>
        [Required]
        [DataMember(Name="manufacturer", EmitDefaultValue=false)]
        public Manufacturer Manufacturer { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class WingDingCreate {\n");
            sb.Append("  Height: ").Append(Height).Append("\n");
            sb.Append("  Width: ").Append(Width).Append("\n");
            sb.Append("  Color: ").Append(Color).Append("\n");
            sb.Append("  Manufacturer: ").Append(Manufacturer).Append("\n");
            sb.Append("}\n");
            return sb.ToString();
        }

        /// <summary>
        /// Returns the JSON string presentation of the object
        /// </summary>
        /// <returns>JSON string presentation of the object</returns>
        public string ToJson()
        {
            return JsonSerializer.Serialize(this, _jsonSerializerOptions);
        }

        /// <summary>
        /// Returns true if objects are equal
        /// </summary>
        /// <param name="obj">Object to be compared</param>
        /// <returns>Boolean</returns>
        public override bool Equals(object obj)
        {
            if (obj is null) return false;
            if (ReferenceEquals(this, obj)) return true;
            return obj.GetType() == GetType() && Equals((WingDingCreate)obj);
        }

        /// <summary>
        /// Returns true if WingDingCreate instances are equal
        /// </summary>
        /// <param name="other">Instance of WingDingCreate to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(WingDingCreate other)
        {
            if (other is null) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    Height == other.Height ||
                    
                    Height.Equals(other.Height)
                ) && 
                (
                    Width == other.Width ||
                    
                    Width.Equals(other.Width)
                ) && 
                (
                    Color == other.Color ||
                    
                    Color.Equals(other.Color)
                ) && 
                (
                    Manufacturer == other.Manufacturer ||
                    Manufacturer != null &&
                    Manufacturer.Equals(other.Manufacturer)
                );
        }

        /// <summary>
        /// Gets the hash code
        /// </summary>
        /// <returns>Hash code</returns>
        public override int GetHashCode()
        {
            unchecked // Overflow is fine, just wrap
            {
                var hashCode = 41;
                // Suitable nullity checks etc, of course :)
                    
                    hashCode = hashCode * 59 + Height.GetHashCode();
                    
                    hashCode = hashCode * 59 + Width.GetHashCode();
                    
                    hashCode = hashCode * 59 + Color.GetHashCode();
                    if (Manufacturer != null)
                    hashCode = hashCode * 59 + Manufacturer.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(WingDingCreate left, WingDingCreate right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(WingDingCreate left, WingDingCreate right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}