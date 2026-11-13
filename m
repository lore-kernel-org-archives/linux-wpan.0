Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544378;
	b=dCFT3TjQR7UVIWDTKlRk02snQs9cme76td84ExSx0jzETp0dGESvAzYNLhTMzm5cODSH
	 hBl1cGneELAcp3vOtABDlrYwt34EEsxuXMFDjjvTqPZKJis74cZtZUK83C0uw/v1bfPuk
	 VqAu28BovrT/983xFTwvxIOmY/kE+hKWO/RpTRXpiCez+0FD1T5mh48sK7YZJk0Vwd20Q
	 LTxwBKj/DxIMV9vvAqLzLt4g2uo9e5A9kP2aQhykTSQp03nLabGWo+VnVyFl2HoXn++Wh
	 ljrbXYwB/nx4EBzdf4KAwZ0LE5zT3Ex3+YpNC0icQBMbyDzOOAOVPqlum+spwbsDSjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KN8v8QuCzsUEq9DsFG7wv9ENbY71UGayeU2tAUDrfIE=;
	b=CJKRhCD+mzscmBVRxh8LJk7WHAXNBujJ//YTGaf6RrBC+FlKNTlqnKfCCxog0/1wEs19
	 mCub5LACohHTQhOCHWW+tbExsOddbvq+2cVtNR3Kp4wkxkQNHhMDmFpx6bkH4RLzwTJRQ
	 49vJ2+yYN8fEfFb1vZx8JFaEqtMsm1iMAUYQSV5qypu8g4VTU0ksVi6uK/dQWRvGt7iMM
	 CPvWQU6+0FG62pjcQrMakNJ4ueo0mc5HHkIPKinfl0zLRjQRNBI4j1PjqSsrK9lR53EIA
	 MCTyMHuaDKco7wjn9hD9DNqQAg6MZ27mVVz15s6LClqV4E9F44Qs6llZz63VTbj6YLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=DWGZbbY9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93769606A321;
	Fri, 13 Nov 2026 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=DWGZbbY9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB421F000C4;
	Fri, 13 Nov 2026 04:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794544378; bh=KN8v8QuCzsUEq9DsFG7wv9ENbY71UGayeU2tAUDrfIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DWGZbbY9Q8w+3c6qpMHrgX3LoR7j2oGBRAMsFGy6kv0QledHbdqMiFZ/vvbLIuPGy
	 j98ZoulQLBwUYmd2qQ4NBXw6Y/XbA0Br49H9vnXEqWvp3ndgtk2s1yE89IQscijnmM
	 FtyaNlzIOrO3eYCY+SJMHkjpZ9FtAIoF1hTxMSsU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,  alex.aring@gmail.com,
  davem@davemloft.net,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  netdev@vger.kernel.org,  linux-wpan@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix netdev_priv() type confusion in
 lowpan_event()
In-Reply-To: <CAL4Wiiq7SweZDnbyBYAfg4rvJxowWtO_5LnB8-hnaNR2K228OQ@mail.gmail.com>
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
	<CAL4Wiiq7SweZDnbyBYAfg4rvJxowWtO_5LnB8-hnaNR2K228OQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.1
Date: Thu, 12 Nov 2026 20:32:56 -0800
Message-ID: <87ik21ic5j.fsf@kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@kernel.org> writes:

> Le ven. 6 nov. 2026 =C3=A0 23:59, Roman Gushchin <roman.gushchin@linux.de=
v> a =C3=A9crit :
>>
>> lowpan_event() assumes any netdevice with dev->type =3D=3D ARPHRD_6LOWPAN
>> has a struct lowpan_dev in netdev_priv(dev). However, non-6LoWPAN
>> devices can also have ARPHRD_6LOWPAN, e.g. a TUN device via TUNSETLINK
>> or a bonding device inheriting dev->type from its lower device.
>>
>> Bringing such a device up or down causes lowpan_event() to read and
>> overwrite unrelated netdev_priv() memory. Since unprivileged users can
>> create TUN and bonding devices in a user and network namespace, they
>> can corrupt struct bonding and trigger a slab use-after-free.
>>
>> Also check dev->ndisc_ops =3D=3D &lowpan_ndisc_ops, which is set only by
>> lowpan_register_netdevice() on genuine 6LoWPAN devices.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compressio=
n")
>> Fixes: 2ad3ed59198c ("6lowpan: add 802.15.4 short addr slaac")
>> Cc: stable@vger.kernel.org
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/bug/linux-97b284e0-576e-4373-b62f-eb132f48=
2b91
>
> nit: Signed-off-by should come last, after Fixes:/Reported-by:/Closes:.
>
> The fix itself looks right to me: lowpan_register_netdevice() is the
> only place setting dev->ndisc_ops to &lowpan_ndisc_ops, and
> bond_setup_by_slave() does not copy ndisc_ops, so this is a reliable
> discriminator.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Thanks.

Thank you for review!

Should I re-spin it with the correct tags order?

Thanks
