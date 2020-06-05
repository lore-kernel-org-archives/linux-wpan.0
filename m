Return-Path: <SRS0=pc//=7S=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F16C433DF
	for <linux-wpan@archiver.kernel.org>; Fri,  5 Jun 2020 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583F22074B
	for <linux-wpan@archiver.kernel.org>; Fri,  5 Jun 2020 11:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bergzand.net header.i=@bergzand.net header.b="YgHGrFZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFELIF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:08:05 -0400
Received: from mail.bergzand.net ([116.203.165.243]:38784 "EHLO
        mail.bergzand.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFELIE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2020 07:08:04 -0400
Received: from [IPv6:2001:470:78ad:2:f9e8:f7c0:313a:e414] (unknown [IPv6:2001:470:78ad:2:f9e8:f7c0:313a:e414])
        by mail.bergzand.net (Postfix) with ESMTPSA id A9738C9379;
        Fri,  5 Jun 2020 13:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bergzand.net;
        s=dkim; t=1591355278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sAbKSgVOZkdRWPtZQTBvl7BGfuaYfX1maMjY7Bb8YWI=;
        b=YgHGrFZ5aT1YXntcF9DjiTLUSGtE4YcDdlg0FNwI8es+NpEwwJXqBkI5gDVUFGk9QfeilG
        MkWJwk/zrzJvg0as7niTIGlCpP09WdZjPV6s/wthJEkiHwx9KZLKAUJRWllTXRfp95cPL1
        PEl2qcg8kIzxCPw6klC+cwIiaWs+fVnkci21b8Y8Vb4zi5VPqiBW7WLGe4QNgvXr8+dQUg
        bL7/9PUjjcVd+AGitPUI2bU74ud9XOBclITeC44dP2fhMwnq8dDFOujhjWeVDGfu+aML3q
        LrK9ZuHtzA3cKMN/aAW8SoAUfoIPBPuPXFHbvM3UUyhQV6Pi+iKQ1wnui8Xm1A==
From:   Koen Zandberg <koen@bergzand.net>
Subject: Re: wpanusb?
To:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Christopher Friedt <chrisfriedt@gmail.com>
Cc:     linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
 <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
 <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
 <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org>
Autocrypt: addr=koen@bergzand.net; keydata=
 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
 h/vSyTr3FSE7fUPvL6WJ1to5dkosYLzBYw0=
Message-ID: <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
Date:   Fri, 5 Jun 2020 13:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6VFZXGPMB9BRMMmDVPJloXyWqmREBjMpW"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6VFZXGPMB9BRMMmDVPJloXyWqmREBjMpW
Content-Type: multipart/mixed; boundary="ovxfZLCF1bFVig5M0iqyKtvF3PwS94OqO"

--ovxfZLCF1bFVig5M0iqyKtvF3PwS94OqO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello

On 03-06-2020 20:18, Stefan Schmidt wrote:
> Hello.
>
> Happy to see that we finally have the critical mass to get this moved
> forward. :-)
>
> Here is my take on what I think needs to be done.
>
> On a first review I found nothing wrong with the design. It needs
> further extending and flexibility in my opinion, though.
I would suggest using USB bulk endpoints for both the tx and rx paths.
An interrupt IN endpoint might be useful for events from the radio back
to the host such as ack information from a transmit. This way we can
keep the control messages to configuration only. This is similar to how
USB ethernet devices are using different USB endpoints. I also see
issues with transferring large 802.15.4g frames over control endpoints.
Something similar like CDC-ECM would be my preference here: Split the
frame in multiple bulk transfers and detect the end of the frame by a
transfer size not equal to the endpoint size.
>
> o Add a GET_EXTENDED_ADDR command to receive the extended address
> provided by the transceiver itself, or firmware in some way.
+1
>
> o Adding a GET_CAPABILITIES command to query device capabilities
> =C2=A0during init to enable and set needed ieee802154_ops based on the
> device. Given that we aim to support as many transceivers as possible
> we can't rely on static device knowledge to configure wpanusb correctly=
=2E
Does it make sense to include also a "protocol" version here, to allow
extending the feature set of the driver later without causing
compatibility issues between the firmware and the kernel?
>
> o Add opcode for set_lbt in USB spec
This requires some clarification for me how the radio should be
configured. Is this just a CSMA/CCA switch?
>
> o Add opcode for set_frame_retries USB spec. (If a transceiver does
> not support AutoACK in hardware do Zephyr and RIOT support a software
> fallback to handle AutoACK?)
This can be implemented in RIOT. I don't think there is something in
place at the moment, most of our radios support this in hardware, but I
see no technical reason why not to support this.
>
> o How are we going to handle transceiver which allow MTUs > 127? Not a
> high priority as the kernel part does not support this either right now=
=2E
There is some preliminary support for 802.15.4g radios in RIOT. I know
some developers that would prefer not to have to have the MTU limited to
127 bytes :)
>
> o Do Zephyr or RIOT expose additional functionality we should support
> here?
>
> o Koen, you offered to look into implementing the firmware support for
> the USB spec in RIOT. Does the spec fit what RIOT has as abstraction
> for ieee802154?

Yes, implementing configuration settings as USB control messages makes
glueing them to the radio abstraction layer very easy. For now RIOT has
configuration for:

=C2=A0- reading and writing channel/page settings
=C2=A0- read/write to addresses, both long and short
=C2=A0- PAN ID
=C2=A0- TX power settings
=C2=A0- reading the max PSDU size
=C2=A0- Ack config settings
=C2=A0- CCA and CSMA configuration, enabling/disabling, retries and backo=
ff
exponent (max/min)
=C2=A0- CCA threshold and mode

Furthermore, it is possible to get frame metadata such as the received
signal strength and the number of retries required for the frame
transmit. All these settings depend a bit on the radio hardware features
of course, but thats what we have the GET_CAPABILITIES for.

Koen



--ovxfZLCF1bFVig5M0iqyKtvF3PwS94OqO--

--6VFZXGPMB9BRMMmDVPJloXyWqmREBjMpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEM1a0jNDzUUT3pcy6CJWok+bSmFsFAl7aJ38ACgkQCJWok+bS
mFvxmQ/+Pj8HIiOIdjgZy0DyKwOHlVKxR83PGStzh6ffYhNpfc85aaZ53BdIEZF8
z5ud4gNPliAHnOHebE4KA43Gng8m0j16gqw2iQlz4EKKRaah8hOniPhRP59hejwX
p05Z5QF6cpU3TPmidjoKfodbWyrQRdpZe00eGynsiow/p0ZvxqlNxSZMVT8UKHqG
D67FsnMFveoOUvZDrsz5LhEeQ4S91YCKTHGNnyUV7EJHHcDx0oG+dBI8KMBOnKht
0nnMQ3scDNyn/JZWTHWGiWoyB6WqrzB26tHE7b6v37WEPJW9G5cNa3AvXwzMJsvK
wj6XSl4lvRAc42XMWdUGy30FGXJ1hIAE8lv77kjBahzy/Y85cA5+lRiJkTx42rDn
n3ftuKmc3+lHlrlNW4I6Gmg7jVnkHCDv+wVFoL7W0HcOAtAvs7TzTaApLG1N9uI0
Dw1/cU4bTyHTHSAjUjj1jcsQvl1HpP0TCXzYT9jA5p6VK/HxiEmcx3LpIVoiIFp9
N0BkhXyKiOOrwKl7Zvg1yNJdyOpYBWWC99d75SpILoUzjxYUrxifYmzCJNhm3reO
PlesrBhUIkAiBpJGFCHtJh0fvzQTY4zAFKLqNMfkDdJaTn0j7RQwN1cWjY8lQRgM
EICJVeaau+J7kmaYhyMf31a6TIM4K5IgLZ7ZtmxFTDXx+5phG3A=
=Zr93
-----END PGP SIGNATURE-----

--6VFZXGPMB9BRMMmDVPJloXyWqmREBjMpW--
