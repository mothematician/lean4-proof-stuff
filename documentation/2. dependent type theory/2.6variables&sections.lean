-- `variables and sections`

  -- declare `variable` names and their types
    -- instructs lean to insert decalred varaibles as bound variables in defs that refer to them by name
    variable (α β γ : Type)
    variable (g : β → γ) (f : α → β) (h : α → α)
    variable (x : α)

    def compose1 := g (f x)
    def doTwice := h (h x)
    def doThrice := h (h (h x))

    #print compose1
    #print doTwice
    #print doThrice

  -- `section`, `end`
    -- for limiting scope of variable to specific sections only
    
    section useful
      variable (α β γ : Type)
      variable (g : β → γ) (f : α → β) (h : α → α)
      variable (x : α)

      def compose2 := g (f x)
      def doTwice2 := h (h x)
      def doThrice2 := h (h (h x))
    end useful
    
    -- after `end` the variable name no longer has the values defined in scope
    -- can also be nested. ie:
    
      section phat
      variable (α β γ : Type)

        section phat1
          variable (g : β → γ) (f : α → β) (h : α → α)
          variable (x : α)

          def compose3 := g (f x)
          def doTwice3 := h (h x)
          def doThrice3 := h (h (h x))
        end phat1

        section phat2
          variable (g : β → γ) (f : α → β) (h : γ → α)(i : γ → β)
          variable (x : γ)

          def compose4 := f (h x)
          def doTwice4 := h (g (i x))
          def doThrice4 := g (f (h x))
        end phat2

      end phat


-- namespace vs sections:
  -- namespace: organize data
  -- sections: declare variables for insertion in definitions, and delimiting scope of commands like `set_option` and `open`

  -- tho in some respects, they behave same:
    -- in particular, use the `variable` command within a namespace, its scope is limited to the namespace