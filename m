Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93F393DC7
	for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166034; cv=none; b=bZ58wTxdIxgM3j6AsWcyGl+zSxrPOi9cx9uq7i5q38SSgEOWWSwZm1ky5lHOEJ0hX1iM4ImQ+91M0nfZKrg+d2kO+krxqIgt5ydE44tDcnRGnx14xno5iLXksSjwpJayxfk81IzacFVxNyfd7jNj0tSOvS9zdECWq3JMwAhq59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166034; c=relaxed/simple;
	bh=txN3mSbG7frTJZNYqOM8nY2RH3YX8pqXlV+lQaEsCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYFRsIt6hNKDnk55E5No7x9Mj26JDZyxF8bH4O9F5ZNlHklCaPZg6clfyw52Q/IN6kuLJv1BxIM02tznsumZdYKkHwkxYOUQCCbaC+2K67TLB6e3nIh1ip4/vn9nnY8qBX9DYCVkFhIZzRO2/Eh04sS4Boha1Fd3n7PdQrPgK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2FfkMlt; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2FfkMlt"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so17718135ad.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166031; x=1785770831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vj9kdGELpsTS+ePCX6BKO0wAnslS+u/Ovbd7+ieC1CM=;
        b=B2FfkMlt3nstB+PBUlYXYFjHjqZjfsK4m90QEfcqX2nOYYbpQi7A7YddO1n3OcxePr
         iuOmZGEiYBA+u579DXj3+skTn0zQnpBqm62DYShSp2NiqJ7cjR3vXqQcbVF6tGfqZDUp
         i+rRlAUHWwL/WzGnXRXVSBoiG8CrtKDjrk3zIpbB738mne1lVYLuNG++N+sMix6Ngtae
         t/9GrTgnMfY54aU4uX43fZ3wyHkUe2GFJjbMHHA8GBySAsRcTW5eG0uKC+m6AGFNRzUe
         Q9K+cxJV5sx8pLp4e7MPJp+2AaaomR+5FXgsPi7DMedl+AL51WJXntQA7JwgezwzuV55
         mPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166031; x=1785770831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vj9kdGELpsTS+ePCX6BKO0wAnslS+u/Ovbd7+ieC1CM=;
        b=II9l6zZbSUwWgZdEW1atODoyXYxxh42FQMWoagjAK4dU74P6kyCTlJb+R139ABFsgv
         HQ3uBvl1cky6Rbo/Bbi6hJLO2+BlVVEdSv3h139zEF5A5ZeTaNdy6CoT2ZmxLEojAdVq
         th5NYW+cBlPfIzilr1DhTKD8suYMWWU/C89stEkKOv9LUFJaodFxmCY39q+vpTa2p1p9
         lbqQ8AAiw0kDVYFL7AuCSD8gpGm4miBmghWT0OOoCpMcyNMZbpQaAJ3O9u0nyFK/TDrf
         ppXbwurqCQq6gz5wZ5dqZ2TB8/oWn26VW8uXiNwk62S7qPb+TPqqZxFO8oJjJhWu9K7+
         rgxw==
X-Forwarded-Encrypted: i=1; AHgh+RqxN2UwWkx4CIFjyOq2Cy4C1GP0GWu7Od510LwyP27zn8w/c5zX6rundaCk5coScGWMaAFhbe+FJ46q@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeDw00DuuvUcxl6d+JJXCF+g3pRGyeGT2cnIMse9QQKR/rbj3
	ifEYveCWnYZbQ0WOTnuFnnDr0SCctKiL6NmlF/+JdAXGzBwQiZ7NBJAx
X-Gm-Gg: AR+sD11NDtkIaEeAiiBCWoDP1ozBQj+Utwvz3nt54yPtTa+URlfXDjb0p/xr5StIe+4
	2PNjc1CEu20WL/Sn8CjY7/IZ6rPrnpMFdR1xgqzPF2UNW20WJqZVt1lZT+MMBmk9dp5m4kc3a+W
	yYHJLr1EPZFbRmqAcgzGB/dQFVuFZprmo0CTBTrsomU+7xD9w93c3xTrRwXuFIvnvFBqD4lKTi5
	FGiK66r8bKCwa81Ao9L9Q5FEXLG8xK4f6ccHUJwzJc0G7JhNFfIW7cb5jQaf3W/T+r19R7hn4TC
	Q21KznyyJoXU2ssfiIze424mROg1LqcUIpRpjK0BlqeZnnhsToBp8ioFXUuOLNriaGoF2uHhcAw
	cF/BtDZ+wEnzuY2DbuAcvIxqMS86FfAcUIhv+wQIjEJ9GGDh15B5BbYspPyA4w/IGzJ7LAz8=
X-Received: by 2002:a17:902:ccc4:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2cfde795b85mr84030495ad.3.1785166030515;
        Mon, 27 Jul 2026 08:27:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm33203245ad.73.2026.07.27.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:10 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:25:12 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 4/7] phonet: pep: do not write beyond optlen
 in getsockopt
Message-ID: <amd4UqADkQNkPfsl@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-4-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-4-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> pep_getsockopt() clamps the reported length to the caller's buffer with
> min_t(), but then stores the value with put_user(val, (int __user *)
> optval), which always writes sizeof(int) bytes. A getsockopt() call with
> an optlen smaller than sizeof(int) thus reports the clamped length yet
> writes a full int, one to three bytes past the user buffer.
> 
> Write the value with copy_to_user() bounded by len, so at most optlen
> bytes are copied, matching the length reported back to userspace.
> 
> Fixes: 02a47617cdce ("Phonet: implement GPRS virtual interface over PEP socket")
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
