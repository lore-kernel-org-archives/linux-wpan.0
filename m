Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:48415 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcCNXLz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Mar 2016 19:11:55 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: 802.15.4G support?
In-Reply-To: <56E6D9F6.70308@osg.samsung.com>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega> <15462.1457122604@obiwan.sandelman.ca> <56E6D9F6.70308@osg.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 14 Mar 2016 19:11:52 -0400
Message-ID: <25857.1457997112@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Stefan Schmidt <stefan@osg.samsung.com> wrote:
    > 2) If the 802.15.4g node uses a SUN PHY with a 2047 byte MTU we can run into
    > trouble with normal nodes only able to handle 127. So far there is nothing
    > specified to handle this case. Michael is proposing to use 6lo ND for this
    > and record the MTU value for this neighbour in the l2 nd cache. Something
    > that would certainly work but would need specing and implementing. I see this
    > as a mid term goal we want to have. Anyone going to work on this?

It's not even clear to me that ND can do this.
I still propose that we want to have a space in the l2 or l3 ND cache for
this info.  It could well go in the L3 cache because it is really a statement
about how the 6lowpan layer should fragment.

    > 3) Until 2) is done I would suggest we add a config option "802.15.4g with
    > SUN PHY" which will change the hardcoded MTU from 127 to 2047 and will thus
    > only work for a 15.g with SUN PHY only network. No interop as we have no way
    > of knowing. The option would be disabled by default and the help text needs
    > to mention the drawbacks. Once we have 2) in place we can remove this.

Couldn't we use "ifconfig blah0 mtu 2047"?

    > Remis, Alex, Michael how does this sound. It would allow Remi to go ahead and
    > do the work needed to get his driver and things for 15.4g mainline while the
    > interop problem can get further discussed, speced and implemented. Whats your
    > folks opinion on this?



--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVudFNYCLcPvd0N1lAQKcxwf8DAb7vlKO4/U3XxTX3Rc22l2M+b2wlVWj
Ma0G0DlV/5HrrN1xJMX57tQ6CliEjhy/cG5JaRYr1eA31tFZAPOUEiYvMH8w8Ogt
NZ3QadnHCH+kdNo+inMp3TiXNz1VkcfodDtld3M/miEYD3Y/xOvFrcjqmdQAzxNp
p9B9qyqljOYKJafzIFOkYbRnbOCpFoKQGc8sHGM/yXLwT9jlay5arkNecs20lcUR
/2btpLjtpjenYAWTzefGFrSEor3EmozE3qzPK3/qG/e5Pls9FuvTTwEoU39C5X8C
jktKpRb7rEElZZbylKp/8bNz5SJXB/sEjzQOjoBdtq3KzeNC2xwF1A==
=YLu8
-----END PGP SIGNATURE-----
--=-=-=--
