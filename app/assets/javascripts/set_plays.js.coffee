# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.overwrite').click ->
		if window.confirm("Overwrite existing next Action Frame?")
			return true
		else
			return false


	$('#AF_anim').click ->
		canvas = $('#court')[0]
		court = canvas.getContext '2d'

		pg_dx = pg_end_x - pg_x
		pg_dy = pg_end_y - pg_y
		pg_len = Math.floor(Math.sqrt(pg_dx*pg_dx + pg_dy*pg_dy))

		sg_dx = sg_end_x - sg_x
		sg_dy = sg_end_y - sg_y
		sg_len = Math.floor(Math.sqrt(sg_dx*sg_dx + sg_dy*sg_dy))

		sf_dx = sf_end_x - sf_x
		sf_dy = sf_end_y - sf_y
		sf_len = Math.floor(Math.sqrt(sf_dx*sf_dx + sf_dy*sf_dy))

		pf_dx = pf_end_x - pf_x
		pf_dy = pf_end_y - pf_y
		pf_len = Math.floor(Math.sqrt(pf_dx*pf_dx + pf_dy*pf_dy))

		c_dx = c_end_x - c_x
		c_dy = c_end_y - c_y
		c_len = Math.floor(Math.sqrt(c_dx*c_dx + c_dy*c_dy))

		ball_dx = ball_end_x - ball_x
		ball_dy = ball_end_y - ball_y
		ball_len = Math.floor(Math.sqrt(ball_dx*ball_dx + ball_dy*ball_dy))

		time = Math.max.apply @, [pg_len, sg_len, sf_len, pf_len, c_len, ball_len]

		i = 0
		drawFrame = ->
			court.clearRect(0, 0, 500, -470)
			court.save

			if ball == "PG"
				if ((pg_x == pg_end_x) && (pg_y == pg_end_y))
					court.fillText("PG", pg_x, pg_y)
				else
					court.fillText("PG", pg_x += i*pg_dx/10, pg_y += i*pg_dy/10)

				if ((sg_x == sg_end_x) && (sg_y == sg_end_y))
					court.fillText("SG", sg_x, sg_y)
				else
					court.fillText("SG", sg_x += i*sg_dx/10, sg_y += i*sg_dy/10)

				if ((sf_x == sf_end_x) && (sf_y == sf_end_y))
					court.fillText("SF", sf_x, sf_y)
				else
					court.fillText("SF", sf_x += i*sf_dx/10, sf_y += i*sf_dy/10)

				if ((pf_x == pf_end_x) && (pf_y == pf_end_y))
					court.fillText("PF", pf_x, pf_y)
				else
					court.fillText("PF", pf_x += i*pf_dx/10, pf_y += i*pf_dy/10)

				if ((c_x == c_end_x) && (c_y == c_end_y))
					court.fillText("C", c_x, c_y)
				else
					court.fillText("C", c_x += i*c_dx/10, c_y += i*c_dy/10)

				if ((ball_x == ball_end_x) && (ball_y == ball_end_y))
					court.beginPath()
					court.arc(ball_x, ball_y, 18, 0, 2*Math.PI)
					court.stroke()
				else
					court.beginPath()
					court.arc(ball_x += i*ball_dx/10, ball_y += i*ball_dy/10, 18, 0, 2*Math.PI)
					court.stroke()

			else if ball == "SG"
				court.fillText("SG", sg_x, sg_y)

				if ((pg_x == pg_end_x) && (pg_y == pg_end_y))
					court.fillText("PG", pg_x, pg_y)
				else
					court.fillText("PG", pg_x += i*pg_dx/10, pg_y += i*pg_dy/10)

				if ((sf_x == sf_end_x) && (sf_y == sf_end_y))
					court.fillText("SF", sf_x, sf_y)
				else
					court.fillText("SF", sf_x += i*sf_dx/10, sf_y += i*sf_dy/10)

				if ((pf_x == pf_end_x) && (pf_y == pf_end_y))
					court.fillText("PF", pf_x, pf_y)
				else
					court.fillText("PF", pf_x += i*pf_dx/10, pf_y += i*pf_dy/10)

				if ((c_x == c_end_x) && (c_y == c_end_y))
					court.fillText("C", c_x, c_y)
				else
					court.fillText("C", c_x += i*c_dx/10, c_y += i*c_dy/10)

				if ((ball_x == ball_end_x) && (ball_y == ball_end_y))
					court.beginPath()
					court.arc(ball_x, ball_y, 18, 0, 2*Math.PI)
					court.stroke()
				else
					court.beginPath()
					court.arc(ball_x += i*ball_dx/10, ball_y += i*ball_dy/10, 18, 0, 2*Math.PI)
					court.stroke()

			else if ball == "SF"
				court.fillText("SF", sf_x, sf_y)

				if ((pg_x == pg_end_x) && (pg_y == pg_end_y))
					court.fillText("PG", pg_x, pg_y)
				else
					court.fillText("PG", pg_x += i*pg_dx/10, pg_y += i*pg_dy/10)

				if ((sg_x == sg_end_x) && (sg_y == sg_end_y))
					court.fillText("SG", sg_x, sg_y)
				else
					court.fillText("SG", sg_x += i*sg_dx/10, sg_y += i*sg_dy/10)

				if ((pf_x == pf_end_x) && (pf_y == pf_end_y))
					court.fillText("PF", pf_x, pf_y)
				else
					court.fillText("PF", pf_x += i*pf_dx/10, pf_y += i*pf_dy/10)

				if ((c_x == c_end_x) && (c_y == c_end_y))
					court.fillText("C", c_x, c_y)
				else
					court.fillText("C", c_x += i*c_dx/10, c_y += i*c_dy/10)

				if ((ball_x <= ball_end_x) && (ball_y <= ball_end_y))
					court.beginPath()
					court.arc(ball_x, ball_y, 18, 0, 2*Math.PI)
					court.stroke()
				else
					court.beginPath()
					court.arc(ball_x += i*ball_dx/10, ball_y += i*ball_dy/10, 18, 0, 2*Math.PI)
					court.stroke()

			else if ball == "PF"
				court.fillText("PF", pf_x, pf_y)

				if ((pg_x == pg_end_x) && (pg_y == pg_end_y))
					court.fillText("PG", pg_x, pg_y)
				else
					court.fillText("PG", pg_x += i*pg_dx/10, pg_y += i*pg_dy/10)

				if ((sg_x == sg_end_x) && (sg_y == sg_end_y))
					court.fillText("SG", sg_x, sg_y)
				else
					court.fillText("SG", sg_x += i*sg_dx/10, sg_y += i*sg_dy/10)

				if ((sf_x == sf_end_x) && (sf_y == sf_end_y))
					court.fillText("SF", sf_x, sf_y)
				else
					court.fillText("SF", sf_x += i*sf_dx/10, sf_y += i*sf_dy/10)

				if ((c_x == c_end_x) && (c_y == c_end_y))
					court.fillText("C", c_x, c_y)
				else
					court.fillText("C", c_x += i*c_dx/10, c_y += i*c_dy/10)

				if ((ball_x == ball_end_x) && (ball_y == ball_end_y))
					court.beginPath()
					court.arc(ball_x, ball_y, 18, 0, 2*Math.PI)
					court.stroke()
				else
					court.beginPath()
					court.arc(ball_x += i*ball_dx/10, ball_y += i*ball_dy/10, 18, 0, 2*Math.PI)
					court.stroke()

			else if ball == "C"
				court.fillText("C", c_x, c_y)

				if ((pg_x == pg_end_x) && (pg_y == pg_end_y))
					court.fillText("PG", pg_x, pg_y)
				else
					court.fillText("PG", pg_x += i*pg_dx/10, pg_y += i*pg_dy/10)

				if ((sg_x == sg_end_x) && (sg_y == sg_end_y))
					court.fillText("SG", sg_x, sg_y)
				else
					court.fillText("SG", sg_x += i*sg_dx/10, sg_y += i*sg_dy/10)

				if ((sf_x == sf_end_x) && (sf_y == sf_end_y))
					court.fillText("SF", sf_x, sf_y)
				else
					court.fillText("SF", sf_x += i*sf_dx/10, sf_y += i*sf_dy/10)

				if ((pf_x == pf_end_x) && (pf_y == pf_end_y))
					court.fillText("PF", pf_x, pf_y)
				else
					court.fillText("PF", pf_x += i*pf_dx/10, pf_y += i*pf_dy/10)

				if ((ball_x == ball_end_x) && (ball_y == ball_end_y))
					court.beginPath()
					court.arc(ball_x, ball_y, 18, 0, 2*Math.PI)
					court.stroke()
				else
					court.beginPath()
					court.arc(ball_x += i*ball_dx/10, ball_y += i*ball_dy/10, 18, 0, 2*Math.PI)
					court.stroke()

			i += 1
		setInterval drawFrame, 85

	