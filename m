Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC5C07545
	for <linux-wpan@archiver.kernel.org>; Wed, 25 Oct 2023 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjJYPnz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 25 Oct 2023 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPny (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Oct 2023 11:43:54 -0400
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 08:43:51 PDT
Received: from tuna.sandelman.ca (tuna.sandelman.ca [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3F12F
        for <linux-wpan@vger.kernel.org>; Wed, 25 Oct 2023 08:43:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tuna.sandelman.ca (Postfix) with ESMTP id 5DBFC1800E;
        Wed, 25 Oct 2023 11:35:47 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FaDrlpVHAfJy; Wed, 25 Oct 2023 11:35:46 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
        by tuna.sandelman.ca (Postfix) with ESMTP id AC0E11800C;
        Wed, 25 Oct 2023 11:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
        s=mail; t=1698248146;
        bh=FIWd0mCyiyZHrjIAE+wkzGEKwAOUOLsnvg2T7ADTdVs=;
        h=From:To:cc:Subject:In-Reply-To:References:Date:From;
        b=bBs9ceZJ0DwOh8Xq05adOej3y7k9n98LPNQgu1loNweb0cL4spN8gPBb5NhgPA6UI
         vAFdJSqltdAQPG4cceymLzyYioDX44tRbN34hmV9gdvMPrfCLn9uLp1KtgH9UX0ebq
         hIDEQyZgnTbvsKfx+afGQD37Z4B8tWZghisSavBsujf6xlx3m7+0R6WmLVm5tVgp5/
         k3r3s46zbsm86LogLq3f+b+uTn5S2E+crSfX2in7679DYD8Y8O0BzXQqfYtEjtEpbT
         ZqbpXiJ47tVVd0MaPZ5soNk8JqFjRzQ8IeyUZOfa0axod7KmnOO/rJb8KYqsI1p/Qh
         pBu64O8jHkLew==
Received: from localhost (localhost [IPv6:::1])
        by sandelman.ca (Postfix) with ESMTP id 7E5A91B6;
        Wed, 25 Oct 2023 11:35:46 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     Mathis Marion <mathis.marion@silabs.com>
cc:     linux-wpan@vger.kernel.org,
        =?us-ascii?Q?=3D=3FUTF-8=3FB=3FSsOpcsO0bWUgUG91aWxsZXI=3D=3F=3D?= 
        <jerome.pouiller@silabs.com>
Subject: Re: RPL lwtunnel encapsulation
In-Reply-To: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com>
References: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 25 Oct 2023 11:35:46 -0400
Message-ID: <13794.1698248146@localhost>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Mathis Marion <mathis.marion@silabs.com> wrote:
    > However, my observations suggest that it is actually not the case when
    > forwarding packets. Instead, the IPv6 header of the packet is modified
    > in a way which violates the IPv6 specification (RFC 8200 section 4):

I have not sat down to read the code to understand what it actually does, so
I can't really comment at this point.  I salute you for having gotten into
whether the code is compliant.

But, I did write spend way too much of my life writing
     https://datatracker.ietf.org/doc/rfc9008/
to deal with the perception that RPL networks had to violate 8200.

I know that Linux does not (yet) deal with all the minutia in 9008.
I wish that I had time to fix that.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmU5NdIRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WU2zAf/cRuEHXQxSDAE+5gPXxTzLCbFoHAfIBvu
prznbJWTnb+eU8edAt4v+KEF+0bdgnU9ipcumA5iqGua5jb34t4U7mb+LHdDxP0X
3bRM1QL1tS3khF8g3v+MZdhO+MkHHmjeAP6VCS8Ktljg8OvTI4P5AKHBLdo+28qa
VNwnaaKG7vRoiNKMiPuiNQ38ECqwYFrsBrOnqYTQFyHebREci5UR91bFj1dX+Hen
/FbaqsBpTfZSHsmKRF7LSfUS0TMlw3PH/2TNJRUn+GHxN1ODA3ou0+RBrTNSTge2
4ZV18sqDW+FSOM47ZPWSZPDmm5oatMmrMzf5DhFfLyOVBYFhXAE+Cw==
=KOKq
-----END PGP SIGNATURE-----
--=-=-=--
