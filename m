Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42AC25B67
	for <linux-wpan@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZOFR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOFQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Oct 2023 10:05:16 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 07:05:13 PDT
Received: from relay.sandelman.ca (relay.cooperix.net [IPv6:2a01:7e00:e000:2bb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F71A2
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2023 07:05:13 -0700 (PDT)
Received: from dyas.sandelman.ca (unknown [206.108.166.29])
        by relay.sandelman.ca (Postfix) with ESMTPS id ADFAD209C2;
        Thu, 26 Oct 2023 13:56:09 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
        id 9565BA135D; Thu, 26 Oct 2023 09:56:08 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
        by dyas.sandelman.ca (Postfix) with ESMTP id 924B2A1346;
        Thu, 26 Oct 2023 09:56:08 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     Alexander Aring <aahringo@redhat.com>,
        Mathis Marion <mathis.marion@silabs.com>,
        linux-wpan@vger.kernel.org,
        =?us-ascii?Q?=3D=3FUTF-8=3FB=3FSsOpcsO0bWUgUG91aWxsZXI=3D=3F=3D?= 
        <jerome.pouiller@silabs.com>
Subject: Re: RPL lwtunnel encapsulation
In-reply-to: <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
References: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com> <13794.1698248146@localhost> <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
Comments: In-reply-to Alexander Aring <aahringo@redhat.com>
   message dated "Wed, 25 Oct 2023 21:03:36 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Thu, 26 Oct 2023 09:56:08 -0400
Message-ID: <3098774.1698328568@dyas>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <aahringo@redhat.com> wrote:
    >> Mathis Marion <mathis.marion@silabs.com> wrote: > However, my
    >> observations suggest that it is actually not the case when >
    >> forwarding packets. Instead, the IPv6 header of the packet is modified
    >> > in a way which violates the IPv6 specification (RFC 8200 section 4):
    >>
    >> I have not sat down to read the code to understand what it actually
    >> does, so I can't really comment at this point.  I salute you for
    >> having gotten into whether the code is compliant.
    >>
    >> But, I did write spend way too much of my life writing
    >> https://datatracker.ietf.org/doc/rfc9008/ to deal with the perception
    >> that RPL networks had to violate 8200.
    >>
    >> I know that Linux does not (yet) deal with all the minutia in 9008.  I
    >> wish that I had time to fix that.

    > To put everything into IPIP and back is not a question of doing a
    > iptunnel ip6tnl [0] and doing the right configuration... just do get
    > everything over "the internet" which I think is the whole reason why
    > putting everything into IPIP?

I agree that modelling it an infinite series of iptunnel/ip6tnl is the wrong approach.
I would model it akin to how ND and ARP work: something that happens which
then resolves into some bytes that get prefixed and/or removed.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmU6b/gACgkQcAKuwszY
gEO8iQwAwwZ3q9K02EWbjZe7SiYKTlpCyZv7jVktDN114Se6NtZEitYvch8CRvHM
IYLduxg9CvYFpun8ELlZICjQX86b8K4d0ikGvB4SaU1OGf4UrB7Mo222hl7TBst9
8Xum7wIuouh17o8c0oLQRE6bvYXS/Bxg8JsbSLA6tbOXNOM6v4d3DnU8g748ijHx
YrSlIXmjGkcoUSJC3v21CMMwngL5CzbAdgY6k24ZXneMC6fuT75K2uwpWjcmBYQn
zW0q33+UaL0ljqj+/NPjw2Mx2JWo/HL+Z8SHl+xQZsdMtmFP38cO3XGHoolSGvoZ
NgGsn8umatXG6eDDtRwwibkQWZJsbA/q6io52RQ5ya+/6UdU7076LNziILAR7N58
1VyYVIbqfDBryWCNmmQEmIcqYvyxUI8/uiah3vPAX09aoS6nt2sEXAtvZkjlM4pz
gn7xoGheMbk0xEbTFIge9JPsAc+Lligw2A+gcfPa5O+CnN1+fdVurjVRM36kGpbv
repUL9BP
=I+HC
-----END PGP SIGNATURE-----
--=-=-=--
