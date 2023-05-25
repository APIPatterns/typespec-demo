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
    public partial class Widget : IEquatable<Widget>
    {
        private JsonSerializerOptions _jsonSerializerOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = true
        };

        /// <summary>
        /// Gets or Sets Weight
        /// </summary>
        [Required]
        [DataMember(Name="weight", EmitDefaultValue=false)]
        public int Weight { get; set; }

        /// <summary>
        /// Gets or Sets Color
        /// </summary>
        [DataMember(Name="color", EmitDefaultValue=false)]
        public WidgetColors Color { get; set; }

        /// <summary>
        /// Gets or Sets Id
        /// </summary>
        [Required]
        [DataMember(Name="id", EmitDefaultValue=false)]
        public string Id { get; set; }

        /// <summary>
        /// Gets or Sets Manufacturer
        /// </summary>
        [Required]
        [DataMember(Name="manufacturer", EmitDefaultValue=false)]
        public Manufacturer Manufacturer { get; set; }

        /// <summary>
        /// Date and time that the resource was created
        /// </summary>
        /// <value>Date and time that the resource was created</value>
        [Required]
        [DataMember(Name="createdOn", EmitDefaultValue=false)]
        public DateTime CreatedOn { get; private set; }

        /// <summary>
        /// Date and time that the resource was last updated
        /// </summary>
        /// <value>Date and time that the resource was last updated</value>
        [Required]
        [DataMember(Name="updatedOn", EmitDefaultValue=false)]
        public DateTime UpdatedOn { get; private set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class Widget {\n");
            sb.Append("  Weight: ").Append(Weight).Append("\n");
            sb.Append("  Color: ").Append(Color).Append("\n");
            sb.Append("  Id: ").Append(Id).Append("\n");
            sb.Append("  Manufacturer: ").Append(Manufacturer).Append("\n");
            sb.Append("  CreatedOn: ").Append(CreatedOn).Append("\n");
            sb.Append("  UpdatedOn: ").Append(UpdatedOn).Append("\n");
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
            return obj.GetType() == GetType() && Equals((Widget)obj);
        }

        /// <summary>
        /// Returns true if Widget instances are equal
        /// </summary>
        /// <param name="other">Instance of Widget to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(Widget other)
        {
            if (other is null) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    Weight == other.Weight ||
                    
                    Weight.Equals(other.Weight)
                ) && 
                (
                    Color == other.Color ||
                    Color != null &&
                    Color.Equals(other.Color)
                ) && 
                (
                    Id == other.Id ||
                    Id != null &&
                    Id.Equals(other.Id)
                ) && 
                (
                    Manufacturer == other.Manufacturer ||
                    Manufacturer != null &&
                    Manufacturer.Equals(other.Manufacturer)
                ) && 
                (
                    CreatedOn == other.CreatedOn ||
                    CreatedOn != null &&
                    CreatedOn.Equals(other.CreatedOn)
                ) && 
                (
                    UpdatedOn == other.UpdatedOn ||
                    UpdatedOn != null &&
                    UpdatedOn.Equals(other.UpdatedOn)
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
                    
                    hashCode = hashCode * 59 + Weight.GetHashCode();
                    if (Color != null)
                    hashCode = hashCode * 59 + Color.GetHashCode();
                    if (Id != null)
                    hashCode = hashCode * 59 + Id.GetHashCode();
                    if (Manufacturer != null)
                    hashCode = hashCode * 59 + Manufacturer.GetHashCode();
                    if (CreatedOn != null)
                    hashCode = hashCode * 59 + CreatedOn.GetHashCode();
                    if (UpdatedOn != null)
                    hashCode = hashCode * 59 + UpdatedOn.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(Widget left, Widget right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(Widget left, Widget right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}