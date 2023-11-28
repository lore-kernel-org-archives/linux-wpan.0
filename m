Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hjJHvO3A"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049461A2
	for <linux-wpan@vger.kernel.org>; Tue, 28 Nov 2023 03:27:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AFAF1BF212;
	Tue, 28 Nov 2023 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++Zycas2TRu7LlPfUZxrr4IkvQeefo47IMQxeTLRlVk=;
	b=hjJHvO3A1TuBJcHfVioRkgcGBfJ/cNXKVJWiroAkCIhUu0Ztz8mH4DACkDUZMlN82r9J09
	lbN9zuJMLwrNK6kMtMv/ImIBqmEHzmLmoBZE0JBWHHhsaiBoOu+upqkAjQ+7knvTcCRiPm
	i+h8z84DJb55rch3LMcOMDZ1gkpo0YlVtyQHq3HbQUOI0gCuIqZi7AaCQ/bZS/4fXiUfe8
	UbG/IE4cQyzqVUkJX9IXR0T9Tf9K7K1VeN7YxeqzvoFBPAunKRbcR0bylUyD1pozXCYlNi
	kz2ZaXY5IvWzIy8lv/0x3OqK77ITQ0cEOfzOnjbAG92zxTle44TpKok3d6W3LA==
Date: Tue, 28 Nov 2023 12:27:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>, Romuald Despres
 <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton
 <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-tools] iwpan: Allow the phy shortcut for scanning
 commands
Message-ID: <20231128122714.10efea31@xps-13>
In-Reply-To: <20230213174703.1172423-1-miquel.raynal@bootlin.com>
References: <20230213174703.1172423-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Stefan,

miquel.raynal@bootlin.com wrote on Mon, 13 Feb 2023 18:47:03 +0100:

> Allow running:
> iwpan phy <phy> scan trigger ...
> iwpan phy <phy> scan abort ...
>=20
> Aside with the existing:
> iwpan dev <dev> scan trigger ...
> iwpan dev <dev> scan abort ...
>=20
> This change does not apply easily to the TOPLEVEL(scan) command, so we
> keep this one more constrained for simplicity.

I believe this patch felt into the cracks, I think I remember it came
from a request from Alex, maybe you will want to consider it for merge
despite its "age"? Or maybe I missed some feedback in the SPAMS /o\

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  src/scan.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/src/scan.c b/src/scan.c
> index e92702d..8bc21ca 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -541,11 +541,15 @@ TOPLEVEL(scan, "type <type> [page <page>] [channels=
 <bitfield>] [duration <durat
>  	SCAN_TYPES);
>  COMMAND(scan, abort, NULL, NL802154_CMD_ABORT_SCAN, 0, CIB_NETDEV, scan_=
abort_handler,
>  	"Abort ongoing scanning on this virtual interface");
> +COMMAND(scan, abort, NULL, NL802154_CMD_ABORT_SCAN, 0, CIB_PHY, scan_abo=
rt_handler, NULL);
>  COMMAND(scan, trigger,
>  	"type <type> [page <page>] [channels <bitfield>] [duration <duration-or=
der>]",
>  	NL802154_CMD_TRIGGER_SCAN, 0, CIB_NETDEV, scan_trigger_handler,
>  	"Launch scanning on this virtual interface with the given configuration=
.\n"
>  	SCAN_TYPES);
> +COMMAND(scan, trigger,
> +	"type <type> [page <page>] [channels <bitfield>] [duration <duration-or=
der>]",
> +	NL802154_CMD_TRIGGER_SCAN, 0, CIB_PHY, scan_trigger_handler, NULL);
> =20
>  SECTION(beacons);
> =20

Thanks,
Miqu=C3=A8l
