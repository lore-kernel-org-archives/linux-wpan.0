Return-Path: <SRS0=4IKq=7M=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B9C433E0
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B198C20774
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bergzand.net header.i=@bergzand.net header.b="XMRtnLQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3SSA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 30 May 2020 14:18:00 -0400
Received: from mail.bergzand.net ([116.203.165.243]:35406 "EHLO
        mail.bergzand.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3SR7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 30 May 2020 14:17:59 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 May 2020 14:17:57 EDT
Received: from [IPv6:2001:470:78ad:2:c02f:1f92:946b:fe3f] (unknown [IPv6:2001:470:78ad:2:c02f:1f92:946b:fe3f])
        by mail.bergzand.net (Postfix) with ESMTPSA id E9570C695D;
        Sat, 30 May 2020 20:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bergzand.net;
        s=dkim; t=1590862231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fh87FPEqZv/eLiGbKpUAWWbYcm1vZE5VaopmXTJ81Ro=;
        b=XMRtnLQcUauR/i4GUH0R7y9M/ya5q2b6+pFmZXWfrFK31MtAH8EMp/xevSVLTQArOhehs2
        +s6/npS7kFybr2fSMWnuDUFIwBBBrorcnbshxYAI3+KfF/YXMFWfw47kB70CvZ2xZyhOom
        7mylVC7a5AZmUSofpcJaABnktHGP8puU2ZhP8iIgkd6hcm3fdRz6eyyzUzCq1wyauyGlwa
        yv3KMvgmX5M2+wMdu1fnUIof/QCnwJi+0FMHDc+CP45/MkksWR0ZrQAUKyTJRlPjbuWIWs
        Fz3VfYTaBt2JZcbSZexO19gQYWaPdP3BcGgLgNJNPcgfA6j1fzkLygjwGvCyRA==
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
 <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
From:   Koen Zandberg <koen@bergzand.net>
Autocrypt: addr=koen@bergzand.net; keydata=
 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
 h/vSyTr3FSE7fUPvL6WJ1to5dkosYLzBYw0=
Message-ID: <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
Date:   Sat, 30 May 2020 20:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o5cpjMaGp2TWmrj5c0LIm5DDVA8mTBubz"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o5cpjMaGp2TWmrj5c0LIm5DDVA8mTBubz
Content-Type: multipart/mixed; boundary="cSxVggj9C66aiDJcUjXUrJLJAOE9UEXHQ"

--cSxVggj9C66aiDJcUjXUrJLJAOE9UEXHQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello all,

Long term RIOT maintainer here.

On 30-05-2020 17:08, Christopher Friedt wrote:
> On Sat, May 30, 2020 at 7:33 AM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>> On 29.05.20 21:33, Christopher Friedt wrote:
>>> On Tue, May 26, 2020 at 3:38 PM Stefan Schmidt
>>> <stefan@datenfreihafen.org> wrote:
>>>> On 25.05.20 14:39, Christopher Friedt wrote:
>>>>> Hi all,
>>>>>
>>>>> Bouncing around a bit, but in Zephyr, there is reference to a
>>>>> "wpanusb" Linux kernel driver here:
>>>>>
>>>>> https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.ht=
ml
>>>>>
>>>>> This *might* be the driver in question:
>>>>>
>>>>> https://github.com/finikorg/wpanusb
>>>>>
>>>>> Just wondering if anyone has made any attempts to submit that, or
>>>>> would that go directly upstream these days?
>>>> I had a chance to talk to the author a while back. Not much activity=

>>>> from his side.
>>> I was chatting with him as well on Zephyr Slack and let him know that=

>>> there was significant interest in it going upstream. I worry though
>>> that it might not be a high priority for his employer.
Most of our developers have of-the-shelve development boards such as the
nrf52840dk and the samr21-xplained pro. For us a generic firmware +
Linux kernel driver would be a very welcome addition to the tool set.
>>>> For me this needs to be designed in a way where we could have bare
>>>> metal, Zephyr, RIOT or Contiki based firmware implementing the inter=
face
>>>> and the driver would just work. The code available is a good start b=
ut
>>>> needs more work.
>>> I'll bring it up in the Zephyr Slack. They want to incorporate it int=
o
>>> their "tools" repository, but it really should go into Linux at some
>>> point.

I'm willing to work on this for a RIOT implementation, assuming there is
some documentation available on the USB protocol side :)
I think I should be able to get a relative generic firmware application
able to run on any of our hardware boards as long as they have a radio
and a USB interface.

Koen



--cSxVggj9C66aiDJcUjXUrJLJAOE9UEXHQ--

--o5cpjMaGp2TWmrj5c0LIm5DDVA8mTBubz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEM1a0jNDzUUT3pcy6CJWok+bSmFsFAl7SoZYACgkQCJWok+bS
mFtflQ/+O3wVrk/WSHj5RoecVCVZPeNeCuRQx6ALNsYmZSBkItmF0Ws8AQjCZohK
GKrIDr/2l2iaLSir+BHgail1tVBP6Ma1pHTr6cSi2J5gOhste1xowcIqsl7tr26A
0T3yDw80yP3+Rl8FzJMa0elMy5oKWxZMKd+BesHWuyPR0krPoLGsWygt7wwhFThv
v0qNekRRo2TfcJ2Co2kHegSpctxBBbMfPotBQTANBdeJvtgH2XT+1/F0XhtrV20v
NnxsK8jw34GlsnT+h8pt1u6/YKyQN1RYfVhH7OuDEyW96PMC9SGyEb4ongDxHy/d
YX0NVulavT0Ch+0+7TwZwpvb6SUZndMKaWsT5tjdGOcxdsZvrFziu8g+1+AwkbKL
3BOC3OHucf8St5Z5mfAh2mke8LUfXfORrs6MJ/9B/a2uDAdQqTDW57zLiCa3lMK0
5CdvO8uEiITZ97QN7dVmA1Icm2WRO0bIXAtVRCbzPX/e7gcmuZyl3D4ZA2iOq+pc
kX658tgDTGjWorlvNkKePKFSYx6YL6iwOtpBaMnceZI3rJBsrFk0HWTtMjhogdmS
gka1q5luZYAuDhI2TA9kBPGMbSgzsT8SYmpDYDPtcrPWQW8nxyg08xTULumAboOS
DtwiZVD48f9g9h0D/+AbEdOg9y5I4gMSflOndPBs9Yo/Zinf26A=
=4nYh
-----END PGP SIGNATURE-----

--o5cpjMaGp2TWmrj5c0LIm5DDVA8mTBubz--
